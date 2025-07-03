import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/auth_controller.dart';
import 'package:sakinah/app/theme/theme.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.grey[200],
                child: Icon(Icons.nightlight_round, size: 32, color: AppColors.accent),
              ),
              const SizedBox(height: 16),
              const Text('Sakinah', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text('Peace & Tranquility', style: TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 32),

              _buildField("Name", Icons.person, authController.nameController, "Your name"),
              const SizedBox(height: 16),
              _buildField("Email", Icons.email_outlined, authController.emailController, "you@email.com", TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildField("Password", Icons.lock_outline, authController.passwordController, "••••••••", TextInputType.visiblePassword, true),
              const SizedBox(height: 24),

              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authController.isLoading.value ? null : authController.register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    authController.isLoading.value ? "Registering..." : "Register",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ),
              )),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    authController.signInWithGoogle();
                  },
                  icon: Image.asset('assets/images/google_logo.png', height: 24, width: 24),
                  label: Text('Continue with Google', style: TextStyle(color: AppColors.primary)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, IconData icon, TextEditingController controller, String hint,
      [TextInputType keyboardType = TextInputType.text, bool obscure = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
