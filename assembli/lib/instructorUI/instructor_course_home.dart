import 'package:assembli/location/instructor_location.dart';
import 'package:flutter/material.dart';
import 'package:assembli/analytics/attendance_analytics.dart';

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
    return Scaffold(body: 
    Center(child: Column(children: <Widget>[
      Container(height: 100,
      width: 250),
      ElevatedButton(onPressed: () {
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
    ),
    ElevatedButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return attendanceAnalytics(
                courseName: widget.courseName,
                courseNumb: widget.courseNumb,
                passedEmail: widget.passedEmail,
              );
            },
          ),
        );
      },
      child: const Text('Student Analytics',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    )
    ]),));

  }
}
