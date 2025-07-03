import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sakinah/app/controllers/home_controller.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find<AuthController>();


  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();



  RxBool isLoading = false.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get user => auth.currentUser;
  String get uid => auth.currentUser?.uid ?? '';

  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _handleAuthChanged);
  }

  void _handleAuthChanged(User? user) async {
    if (user == null) {
      Get.offAllNamed('/login');
    } else {
      await user.reload(); // Refresh user data
      if (user.emailVerified) {
        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/verify');
      }
    }
  }

  /// 🔐 Email Login
  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/home'); // ✅ navigate after login
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    }
  }

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      Get.snackbar('Error', 'All fields are required.');
      return;
    }

    isLoading.value = true;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Get.snackbar(
          'Verify Email',
          'A verification link has been sent to your email.',
        );
        Get.toNamed('/verify-email'); // Navigate to verify view
      } else {
        Get.snackbar('Error', 'User creation failed or already verified.');
      }
    } catch (e) {
      Get.snackbar('Register Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔵 Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Get.snackbar("Cancelled", "Google sign-in was cancelled");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );
      User? user = userCredential.user;

      // Save to Firestore if new user
      final doc = await firestore.collection('users').doc(user!.uid).get();
      if (!doc.exists) {
        await firestore.collection('users').doc(user.uid).set({
          'user_id': user.uid,
          'email': user.email,
          'username': user.displayName ?? '',
          'language': 'en',
          "notifications_enabled": true,
          'favorites': [],
          'last_read': {},
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      // ✅ Navigate to home page
      Get.offAllNamed('/home');
    } catch (e) {
      print("Google Sign-In Error: $e");
      Get.snackbar("❌ Google Sign-In Failed", e.toString());
    }
  }

  /// 🚪 Logout
  Future<void> logout() async {
    await auth.signOut();
    await GoogleSignIn().signOut(); // Also logout from Google
    
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
