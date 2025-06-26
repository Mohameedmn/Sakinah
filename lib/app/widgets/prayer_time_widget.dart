import 'package:flutter/material.dart';

class PrayerTimeWidget extends StatelessWidget {
  final String prayerName;
  final String time;
  final IconData icon;
  final Color? backgroundColor;
  final String hijriDate;
  final String nextprayertime; // Example remaining time

  const PrayerTimeWidget({
    super.key,
    required this.prayerName,
    required this.time,
    this.icon = Icons.access_time,
    this.backgroundColor,
    required this.hijriDate,
    required this.nextprayertime,
  });

  

  Duration getRemainingTime() {
    DateTime now = DateTime.now();

    DateTime prayerTime = nextprayertime.isNotEmpty
        ? DateTime.parse(nextprayertime)
        : DateTime(now.year, now.month, now.day, 5, 0);
        
    Duration remaining = prayerTime.difference(now);

    
    return remaining; 
  }

  String formatRemainingTime(Duration duration) {

    if (duration.isNegative) return "Already passed";
      int hours = duration.inHours;
      int minutes = duration.inMinutes.remainder(60);
   return "$hours h $minutes m remaining";
  }


  String getPrayerImage(String prayerName) {
    switch (prayerName.toLowerCase()) {
      case 'fajr':
        return 'assets/images/fajr_image.jpg';
      case 'duhr':
      case 'dhuhr':
        return 'assets/images/duhr_image.jpg';
      case 'asr':
        return 'assets/images/asr_image.jpg';
      case 'maghrib':
        return 'assets/images/maghrib_image.jpg';
      case 'isha':
        return 'assets/images/ishaa_image.jpg';
      default:
        return 'assets/images/duhr_image.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220, // ✅ Fixed height to avoid layout error
      width: double.infinity, // ✅ Full width
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(getPrayerImage(prayerName)),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.black.withOpacity(0.4),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Align(
                  alignment: Alignment.centerRight,
                    child :Text(
                    hijriDate,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      const Text(
                        'remaining time',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formatRemainingTime(getRemainingTime())
                        ,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(icon, color: Colors.white),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          prayerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
