import 'package:flutter/material.dart';

class StudentCourseHome extends StatefulWidget {
  const StudentCourseHome({super.key});

  @override
  State<StudentCourseHome> createState() => _StudentCourseHomeState();
}

class _StudentCourseHomeState extends State<StudentCourseHome> {

  @override
  Widget build(BuildContext context) {
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

//ref to change (moved from stateless to stateful)//////////////////////////////////
/*
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
*/
