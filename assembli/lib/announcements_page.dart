import 'package:flutter/material.dart';

//class holds basis for announcements destination; 
//will work similar to landing, linking other pages/states 
//(linked from navigationBar destination in landing.dart) 

class AnnouncementsPage extends StatelessWidget {
const AnnouncementsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const Center(
        child: Text("Announcements Page"),
      );
  }
}