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
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Failed', e.message ?? 'Unknown error');
    } catch (e) {
      Get.snackbar('Login Failed', 'An unexpected error occurred');
    }
  }

  // 🧾 Register
  Future<void> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Account created');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Registration Failed', e.message ?? 'Unknown error');
    } catch (e) {
      Get.snackbar('Registration Failed', 'An unexpected error occurred');
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      await GoogleSignIn().signOut();
      Get.snackbar('Success', 'Logged out');
    } catch (e) {
      Get.snackbar('Logout Failed', 'An unexpected error occurred');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // 1. Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Get.snackbar("Cancelled", "Google sign-in was cancelled");
        return;
      }

      // 2. Obtain the auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. Create the credentials
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Sign in to Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);

      // ✅ 5. Redirect to home
      Get.offAllNamed('/home'); // or AppRoute.home if you use route constants
    } catch (e) {
      print("❌ Google Sign-In Error: $e");
      Get.snackbar("Google Sign-In Failed", e.toString());
    }
  }
}
