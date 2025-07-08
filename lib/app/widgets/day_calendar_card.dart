import 'package:flutter/material.dart';
import 'package:sakinah/app/theme/theme.dart';

class DayCalendarCard extends StatelessWidget {
  const DayCalendarCard({super.key, required this.day, required this.isChecked, required this.date});

  final int date;
  final String day;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(day , 
        style: TextStyle(
          fontSize: 12,
          color: AppColors.grayFont,
        ),),
        SizedBox(height: 5,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isChecked ? AppColors.primary : Colors.white,
            border: BoxBorder.all(
              color: AppColors.primary,
              width: 1.5
            )
          ),
          width: 50,
          height:50,
          child: Center(
            child: Text("$date",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isChecked? Colors.white: AppColors.primary,
            ),)
            ,
          ),
          
        
        ),
      ],
    );
  }
}
