import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sakinah/app/controllers/home_controller.dart';
import 'package:sakinah/app/widgets/custom_bottom_nav_bar.dart';
// import 'package:flutter_compass/flutter_compass.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

class QiblaView extends StatefulWidget {
   QiblaView({super.key});
  final HomeController controller = Get.find<HomeController>();
  @override
  State<QiblaView> createState() => _QiblaViewState();
}

class _QiblaViewState extends State<QiblaView> {
  // double? _direction;

  @override
  void initState() {
    super.initState();

    // _requestPermissions();
    // FlutterCompass.events?.listen((event) {
    //   setState(() => _direction = event.heading);
    // });
  }

  // Future<void> _requestPermissions() async {
  //   await Permission.locationWhenInUse.request();
  // }

  @override
  Widget build(BuildContext context) {
    // final angle = ((_direction ?? 0) * (pi / 180) * -1);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Qibla Direction'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: const Center(
        // Replace the Qibla compass with a placeholder message or image
        child: Text(
          "Qibla direction will be shown here.\n(Sensor disabled)",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(controller: widget.controller),

    );
  }
}
