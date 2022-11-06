import 'package:flutter/material.dart';


class StudentAnnouncementsPage extends StatefulWidget {
  const StudentAnnouncementsPage({super.key});  

  @override
  State<StudentAnnouncementsPage> createState() => _StudentAnnouncementsPage();

}

class _StudentAnnouncementsPage extends State<StudentAnnouncementsPage>{
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        ListTile(
          leading: Text("(12/04)"),
          trailing: Text("Class Cancelled"),
          title: Text("CS-4366"),
        ),
        ListTile(
          leading: Text("(11/22)"),
          trailing: Text("Class Cancelled"),
          title: Text("CS-4352"),
        ),
        ListTile(
          leading: Text("(11/20)"),
          trailing: Text("Class Cancelled"),
          title: Text("CS-4354"),
        ),
        ListTile(
          leading: Text("(10/31)"),
          trailing: Text("Class Cancelled"),
          title: Text("CS-4366"),
        ),
        ListTile(
          leading: Text("(09/10)"),
          trailing: Text("Class Cancelled"),
          title: Text("BA-3305"),
        ),
        ListTile(
          leading: Text("(08/18)"),
          trailing: Text("Class Cancelled"),
          title: Text("CS-4354"),
        ),
      ],
    );
  }
}

