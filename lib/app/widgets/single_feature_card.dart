import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme/theme.dart';

class SingleFeatureCard extends StatelessWidget {
  const SingleFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.ontap,
  });

  final String title;
  final IconData icon;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ontap,
      child: Column(
        children: [
          FaIcon(icon, size: 20),
          Text(
            title,
            style: TextStyle(color: AppColors.primary, fontSize: 12,),
            
          ),
        ],
      ),
    );
  }
}
