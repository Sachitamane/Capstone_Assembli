import 'package:flutter/material.dart';
import 'package:assembli/location.dart';
import 'package:assembli/instructorUI/instructor_announcement.dart';

class InstructorCourseHome extends StatelessWidget {
  const InstructorCourseHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
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
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    Color.fromARGB(255, 179, 194, 168))),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return InstructorAnnouncement();
                  },
                ),
                (route) => false,
              );
            },
            child: const Text('Make Announcement',
                style: TextStyle(color: Colors.white, fontSize: 25)),
          )
        ],
      ),
    );
  }
}
