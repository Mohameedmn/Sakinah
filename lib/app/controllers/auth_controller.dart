import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get user => auth.currentUser;
  String get uid => auth.currentUser?.uid ?? '';


  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.authStateChanges());
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

  /// 🧾 Register with Firestore user creation
  Future<void> register(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await firestore.collection('users').doc(user.uid).set({
          'user_id': user.uid,
          'email': user.email,
          'language': 'en',
          'favorites': [],
          'last_read': {},
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      Get.snackbar('✅ Success', 'Account created');
      Get.offAllNamed('/home'); // ✅ navigate after login
    } catch (e) {
      Get.snackbar('❌ Registration Failed', e.toString());
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
          'language': 'en',
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
}
