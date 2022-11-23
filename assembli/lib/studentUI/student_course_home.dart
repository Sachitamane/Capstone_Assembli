import 'package:assembli/location.dart';
import 'package:assembli/studentUI/student_create_request.dart';
import 'package:flutter/material.dart';
//import 'package:assembli/location.dart';

class StudentCourseHome extends StatefulWidget {
  
  final String courseName;
  final int courseNumb;

  const StudentCourseHome({
    Key? key,
    required this.courseName,
    required this.courseNumb,
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
    //body: const Center(child: Text("Location"),)
    body: Column(children: <Widget>[
        ElevatedButton(
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
                  return const StudentCreateRequest();
                },
              ),
              (route) => false,
            );
          },
          child: const Text('Request Excused Absence',
              style: TextStyle(color: Colors.white, fontSize: 25)),
        ),
      ]));

}
//old StudentCourseHomeState
/*
class _StudentCourseHomeState extends State<StudentCourseHome> {
  //const StudentCourseHome({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
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