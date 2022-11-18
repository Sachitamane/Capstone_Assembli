import 'package:flutter/material.dart';
import 'package:assembli/location/student_location.dart';

class StudentCourseHome extends StatefulWidget {
  final String courseName;
  final int courseNumb;
  final String passedEmail;

  const StudentCourseHome({
    Key? key,
    required this.courseName,
    required this.courseNumb,
    required this.passedEmail,
  }) : super(key: key);

  @override
  State<StudentCourseHome> createState() => _StudentCourseHomeState();
}

class _StudentCourseHomeState extends State<StudentCourseHome> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        title: Text(widget.courseName),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(100),
              child: ElevatedButton(
                onPressed: (() => {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return LocationFinder(
                              courseName: widget.courseName,
                              courseNumb: widget.courseNumb,
                              passedEmail: widget.passedEmail,
                            );
                          },
                        ),
                        (route) => false,
                      )
                    }),
                child: const Text("Log Attendance"),
              ))
        ],
      )));
}
