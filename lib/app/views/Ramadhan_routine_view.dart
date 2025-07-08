import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/theme/theme.dart';
import 'package:sakinah/app/widgets/day_calendar_card.dart';
import 'package:sakinah/app/widgets/new_task_card.dart';
import 'package:sakinah/app/widgets/task_bar.dart';

class RamadhanRoutineView extends StatelessWidget {
  const RamadhanRoutineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: AppColors.primary,
        title: Center(
          child: Text(
            "Ramadhan Routine",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        actions: [Icon(Icons.settings, color: Colors.white, size: 24)],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DayCalendarCard(day: "Fri", isChecked: true, date: 12),
                    SizedBox(width: 8),
                    DayCalendarCard(day: "Sat", isChecked: false, date: 13),
                    SizedBox(width: 8),
                    DayCalendarCard(day: "Sun", isChecked: false, date: 14),
                    SizedBox(width: 8),
                    DayCalendarCard(day: "Mon", isChecked: false, date: 15),
                    SizedBox(width: 8),
                    DayCalendarCard(day: "Tue", isChecked: false, date: 16),
                    SizedBox(width: 8),
                    DayCalendarCard(day: "Wed", isChecked: false, date: 17),
                    SizedBox(width: 8),
                    DayCalendarCard(day: "Thu", isChecked: false, date: 18),
                    SizedBox(width: 8),
                    DayCalendarCard(day: "Fri", isChecked: false, date: 19),
                    SizedBox(width: 8),
                    DayCalendarCard(day: "Sat", isChecked: false, date: 20),
                    SizedBox(width: 8),
                    DayCalendarCard(day: "Sun", isChecked: false, date: 21),
                    SizedBox(width: 8),
                    DayCalendarCard(day: "Mon", isChecked: false, date: 22),
                  ],
                ),
              ),
              SizedBox(height: 20),
          
              Row(
                children: [
                  Icon(Icons.error, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    "Skipped 1 activity Today",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(width: 55),
                  NewTaskCard(),
                ],
              ),
              SizedBox(height: 20),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Activity",
                    style: TextStyle(
                      color: AppColors.grayFont,
                      fontWeight: FontWeight.bold,
          
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 55),
                  Text(
                    "4/14",
                    style: TextStyle(
                      color: AppColors.grayFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 20),
              TaskBar(
                title: "Tahajjud Prayer",
                timeDebut: "02:00 AM",
                timeEnd: "04:00 AM",
                isSkipped: true,
                isDone: false,
              ),
              SizedBox(height: 5),
          
              TaskBar(
                title: "Sahoor",
                timeDebut: "04:00 AM",
                timeEnd: "04:30 AM",
                isDone: true,
              ),
              SizedBox(height: 5),
              TaskBar(
                title: "Fajer Prayer",
                timeDebut: "04:45 AM",
                timeEnd: "05:15 AM",
                isDone: true,
              ),
              SizedBox(height: 5),
              TaskBar(
                title: "Reading Quran",
                timeDebut: "05:30 AM",
                timeEnd: "06:30 AM",
                isDone: true,
              ),
              SizedBox(height: 5),
              TaskBar(
                title: "Duhr Prayer",
                timeDebut: "12:50 AM",
                timeEnd: "01:00 PM",
                isDone: false,
              ),
              SizedBox(height: 5),
              TaskBar(
                title: "Asr Prayer",
                timeDebut: "03:45 AM",
                timeEnd: "04:00 AM",
                isDone: false,
              ),
              SizedBox(height: 5),
              TaskBar(
                title: "Maghrib Prayer",
                timeDebut: "07:55 AM",
                timeEnd: "08:10 AM",
                isDone: false,
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
