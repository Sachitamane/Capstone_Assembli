import 'package:flutter/material.dart';
import 'package:assembli/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InstructorCourseHome extends StatefulWidget {
  final String courseName;
  final int courseNumb;

  const InstructorCourseHome({
    Key? key,
    required this.courseName,
    required this.courseNumb,
  }) : super(key: key);

  @override
  State<InstructorCourseHome> createState() => _InstructorCourseHomeState();
}

class _InstructorCourseHomeState extends State<InstructorCourseHome> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        title: Text(widget.courseName),
      ),
      body: ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 179, 194, 168)),
            fixedSize: MaterialStatePropertyAll(Size(400, 20))),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const LocationSetter();
              },
            ),
            (route) => false,
          );
        },
        child: const Text('Open Attendance',
            style: TextStyle(color: Colors.white, fontSize: 25)),
      ));
}
