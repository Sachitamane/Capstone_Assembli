import 'package:flutter/material.dart';
import 'package:assembli/location.dart';
import 'package:assembli/instructorUI/instructor_announcement.dart';
import 'package:assembli/user.dart';

class InstructorCourseHome extends StatefulWidget {
  const InstructorCourseHome({super.key});

  @override
  State<InstructorCourseHome> createState() => _InstructorCourseHomeState();
}

class _InstructorCourseHomeState extends State<InstructorCourseHome> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        title: Text(User.cname),
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 179, 194, 168))),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 179, 194, 168))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const InstructorAnnouncement();
                    },
                  ),
                );
              },
              child: const Text('Make Announcement',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          )
        ],
      )),
    );
  }
}
