import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/auth_controller.dart';
import 'package:sakinah/app/controllers/home_controller.dart';
import 'package:sakinah/app/services/location_services.dart';
import 'package:sakinah/app/widgets/custom_bottom_nav_bar.dart';
import 'package:sakinah/app/widgets/profile_row.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final HomeController controller = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          const CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage('assets/images/avatar_logo.jpg'),
          ),

          const SizedBox(height: 10),
          const Text(
            "Mohamed Mansouri",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          FutureBuilder<Map<String, String>>(
            future: getCityAndCountry(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Locating...", style: TextStyle(color: Colors.grey));
              } else if (snapshot.hasError || !snapshot.hasData) {
                return const Text("Location error", style: TextStyle(color: Colors.red));
              } else {
                final city = snapshot.data!['city'] ?? '';
                final country = snapshot.data!['country'] ?? '';
                return Text("$city, $country", style: const TextStyle(color: Colors.grey));
              }
            },
          ),

          const SizedBox(height: 20),

          // 🧾 Profile Card
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                children: [
                  ProfileRow(
                    icon: Icons.email,
                    name: "Email",
                    value: "mohamed@example.com",
                  ),
                  const Divider(),
                  ProfileRow(
                    icon: Icons.phone,
                    name: "Phone",
                    value: "+213 555 123 456",
                  ),
                  const Divider(),
                  ProfileRow(
                    icon: Icons.person,
                    name: "Username",
                    value: "mohamedmn",
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.notifications_active, color: Colors.green),
                          SizedBox(width: 12),
                          Text(
                            "Notifications",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Switch(
                        value: true,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          // Handle toggle
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          // 🔴 Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton.icon(
              onPressed: () async {
                await authController.logout();
                Get.offAllNamed('/login'); // Adjust route if needed
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(controller: controller),
    );
  }
}
