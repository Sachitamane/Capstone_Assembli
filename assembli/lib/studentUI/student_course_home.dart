import 'package:flutter/material.dart';
import 'package:assembli/location.dart';

class StudentCourseHome extends StatelessWidget {
  //const StudentCourseHome({ Key? key }) : super(key: key);

  final String courseName;
  final int courseNumb;

  const StudentCourseHome({
    Key? key,
    required this.courseName,
    required this.courseNumb,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 179, 194, 168),
      title: Text(courseName),
    ),
    body: const Center(child: Text("Location"),)
  );
}

// might need a constructor to pass data from student_courses_page.dart
/*
class StudentCourseHome extends StatefulWidget {
  const StudentCourseHome({super.key});

  @override
  State<StudentCourseHome> createState() => _StudentCourseHomeState();
}

class _StudentCourseHomeState extends State<StudentCourseHome> {
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
                      return const LocationFinder();
                    },
                  ),
                  (route) => false,
                );
      },
      child: const Text('Log my Attendance',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    ));
  }
}

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
      onPressed: () {
            Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const LocationFinder();
                    },
                  ),
                  (route) => false,
                );
      },
      child: const Text('Log my Attendance',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    ));
  }
}
*/
