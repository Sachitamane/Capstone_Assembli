import 'package:assembli/location/instructor_location.dart';
import 'package:flutter/material.dart';

class InstructorCourseHome extends StatefulWidget {
  final String courseName;
  final int courseNumb;
  final String passedEmail;

  const InstructorCourseHome({
    Key? key,
    required this.courseName,
    required this.courseNumb,
    required this.passedEmail,
  }) : super(key: key);

  @override
  State<InstructorCourseHome> createState() => _InstructorCourseHomeState();
}

class _InstructorCourseHomeState extends State<InstructorCourseHome> {
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
              return LocationSetter(
                courseName: widget.courseName,
                courseNumb: widget.courseNumb,
                passedEmail: widget.passedEmail,
              );
            },
          ),
          (route) => false,
        );
      },
      child: const Text('Open Attendance',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    ));
  }
}
