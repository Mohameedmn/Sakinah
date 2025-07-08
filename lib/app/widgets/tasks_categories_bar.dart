import 'package:flutter/material.dart';
import 'package:sakinah/app/theme/theme.dart';

class TasksCategoriesBar extends StatelessWidget {
  const TasksCategoriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 25,
        left: 25,
        top: 10,
        bottom: 10
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text(
                "All",
                style: TextStyle(
                  color: AppColors.grayFont,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Container(
                height: 15,
                width: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  "54",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 22,
            child: VerticalDivider(color: Colors.grey.shade400, thickness: 1.5),
          ),

          Row(
            children: [
              Text(
                "done",
                style: TextStyle(
                  color: AppColors.grayFont,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Container(
                height: 15,
                width: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  "3",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Ongoing",
                style: TextStyle(
                  color: AppColors.grayFont,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Container(
                height: 15,
                width: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 24, 41, 59),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  "12",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Skipped",
                style: TextStyle(
                  color: AppColors.grayFont,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Container(
                height: 15,
                width: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  "1",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
