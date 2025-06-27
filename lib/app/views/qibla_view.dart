import 'dart:math';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sakinah/app/services/location_services.dart';
import 'package:sakinah/app/widgets/custom_bottom_nav_bar.dart';
import 'package:sakinah/app/controllers/home_controller.dart';

class QiblaView extends StatefulWidget {
  const QiblaView({super.key});

  @override
  State<QiblaView> createState() => _QiblaViewState();
}

class _QiblaViewState extends State<QiblaView> {
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}
