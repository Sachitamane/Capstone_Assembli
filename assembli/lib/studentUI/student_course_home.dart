import 'package:flutter/material.dart';
import 'package:assembli/location.dart';
import 'package:assembli/studentUI/student_create_request.dart';

class StudentCourseHome extends StatelessWidget {
  const StudentCourseHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          // ignore: prefer_const_constructors
          body: Column(children: <Widget>[
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 179, 194, 168))),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const LocationFinder();
                },
              ),
              (route) => false,
            );
          },
          child: const Text('Log my Attendance',
              style: TextStyle(color: Colors.white, fontSize: 25)),
        ),
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 179, 194, 168))),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const StudentCreateRequest();
                },
              ),
              (route) => false,
            );
          },
          child: const Text('Request Excused Absence',
              style: TextStyle(color: Colors.white, fontSize: 25)),
        ),
      ]));
}
