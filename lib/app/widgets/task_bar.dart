import 'package:flutter/material.dart';
import 'package:sakinah/app/theme/theme.dart';

class TaskBar extends StatelessWidget {
  const TaskBar({
    super.key,
    required this.title,
    required this.timeDebut,
    required this.timeEnd,
    this.isSkipped = false,
    required this.isDone,
  });

  final String title;
  final String timeDebut;
  final String timeEnd;
  final bool isSkipped ;
  final bool isDone;

  Color get firstColor {
    if (isSkipped) {
      return Colors.grey.shade400;
    } else if (isDone) {
      return AppColors.primary;
    } else {
      return Colors.white;
    }
  }

  Color get secondColor {
    if (isSkipped) {
      return Colors.grey.shade400;
    } else if (isDone) {
      return AppColors.secondary;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(
          right: 16,
          left: 16,
          top: 8
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [firstColor, secondColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 5),
            Column(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, color: isDone ? Colors.white : Colors.black),
                ),
                SizedBox(height: 5),
                Text(
                  "$timeDebut - $timeEnd",
                  style: TextStyle(fontSize: 18, color: isDone ? Colors.white : Colors.black),
                ),
              ],
            ),
            SizedBox(width: 5),

            isDone
                ? Icon(Icons.check_circle, color: Colors.white)
                : Icon(Icons.circle_outlined, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
