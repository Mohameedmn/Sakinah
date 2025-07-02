import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.authStateChanges());
  }

  // 🔐 Email login
  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Logged in successfully');
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    }
  }

  // 🧾 Register
  Future<void> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Account created');
    } catch (e) {
      Get.snackbar('Registration Failed', e.toString());
    }
  }

  // 🚪 Logout
  Future<void> logout() async {
    await auth.signOut();
    await GoogleSignIn().signOut(); // Also logout from Google
  }

  // 🔵 Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Get.snackbar("Cancelled", "Google sign-in was cancelled");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      Get.snackbar("Success", "Signed in with Google");
    } catch (e) {
      Get.snackbar("Google Sign-In Failed", e.toString());
    }
  }
}
