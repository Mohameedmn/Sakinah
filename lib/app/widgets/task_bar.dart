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
  final bool isSkipped;
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
        
        height: 65,
        padding: EdgeInsets.all(11),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color:  Colors.grey,
              blurRadius: .7,
              offset: Offset.zero,

          ),
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            
            colors: [firstColor, secondColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
          
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    color: isDone ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  "$timeDebut - $timeEnd",
                  style: TextStyle(
                    fontSize: 12,
                    color: isDone ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            
            isSkipped? Icon(Icons.pause_circle_outlined ,color: Colors.white)
            :
            isDone
                ? Icon(Icons.check_circle, color: Colors.white)
                : Icon(Icons.circle_outlined, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
