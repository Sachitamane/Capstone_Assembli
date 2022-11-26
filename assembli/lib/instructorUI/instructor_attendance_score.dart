import 'package:flutter/material.dart';
import 'instructor_course_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class AttendanceScore extends StatefulWidget {
  const AttendanceScore({Key? key}) : super(key: key);

  //CollectionReference announce = FirebaseFirestore.instance.collection('Announcement');
  @override
  State<AttendanceScore> createState() => _AttendanceScore();
}

class _AttendanceScore extends State<AttendanceScore> {
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
