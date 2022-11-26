import 'package:flutter/material.dart';
import 'package:assembli/location.dart';

class StudentCourseHome extends StatelessWidget {
  const StudentCourseHome(
      {Key? key, required String courseName, required int courseNumb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Center(
        child: ElevatedButton(
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
    ));
  }
}
