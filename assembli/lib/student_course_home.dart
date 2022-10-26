import 'package:flutter/material.dart';

class StudentCourseHome extends StatelessWidget {
  const StudentCourseHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Center(
        child: ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 179, 194, 168))),
      onPressed: () {},
      child: const Text('Log my Attendance',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    ));
  }
}
