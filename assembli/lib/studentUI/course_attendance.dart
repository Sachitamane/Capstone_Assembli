import 'package:flutter/material.dart';

class CourseAttendance extends StatefulWidget {
  const CourseAttendance({super.key});

  @override
  State<CourseAttendance> createState() => _CourseAttendanceState();
}

class _CourseAttendanceState extends State<CourseAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 179, 194, 168),
      title: const Text('Course attendance'),

      ),
      body : const Center(
        child:  Text('attendence page'))

    );
  }
}