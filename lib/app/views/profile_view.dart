import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/home_controller.dart';
import 'package:sakinah/app/services/location_services.dart';
import 'package:sakinah/app/widgets/custom_bottom_nav_bar.dart';
import 'package:sakinah/app/widgets/profile_row.dart'; // Adjust import

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final HomeController controller = Get.find<HomeController>();

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
            backgroundImage: AssetImage('assets/images/avatar_logo.jpg'), // Replace with your asset or network image
          ),
          const SizedBox(height: 10),
          const Text(
            "Mohamed Mansouri",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          FutureBuilder<String>(
            future: getProvinceAndCountry(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Locating...", style: TextStyle(color: Colors.grey));
              } else if (snapshot.hasError) {
                return const Text("Location error", style: TextStyle(color: Colors.red));
              } else {
                return Text(
                  snapshot.data ?? "",
                  style: const TextStyle(color: Colors.grey),
                );
              }
            },
          ),
          const SizedBox(height: 20),

          // 🧾 Profile Info Card
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                children: [
                  ProfileRow(icon: Icons.email, name :"Email",value: "mohamed@example.com"),
                  const Divider(),
                  ProfileRow(icon: Icons.phone, name: "Phone", value: "+213 555 123 456"),
                  const Divider(),
                  ProfileRow(icon :Icons.person,name: "Username", value: "mohamedmn"),
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
                        onChanged: (value) {
                          // Handle notification toggle
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(controller: controller),
    );
  }

}
