import 'package:flutter/material.dart';
import 'package:sakinah/app/theme/theme.dart';

class NewTaskCard extends StatelessWidget {
  const NewTaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Container(
        height: 40,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [AppColors.primary , AppColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

          ),
           
      
        ),
      
        child: Row(
          children: [
            SizedBox(width: 5,),
            Icon(Icons.add , color: Colors.white,),
            SizedBox(width: 10,),
            Text("New Task" , style: TextStyle(fontSize: 12, color: Colors.white),),
            SizedBox(width: 5,),
          ],
        ),
      ),
    );
  }
}