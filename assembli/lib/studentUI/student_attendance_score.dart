import 'package:flutter/material.dart';
import 'student_course_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class StudentAttendanceScore extends StatefulWidget {
  const StudentAttendanceScore({Key? key}) : super(key: key);

  //CollectionReference announce = FirebaseFirestore.instance.collection('Announcement');
  @override
  State<StudentAttendanceScore> createState() => _StudentAttendanceScore();
}

class _StudentAttendanceScore extends State<StudentAttendanceScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        title: const Text('Assembli'),
      ),
      body: Center(
        child: Column(children: const [
          Padding(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 75.0, bottom: 45.0),
              child: Text('add attendance score view here')),
        ]),
      ),
    );
  }
}
