import 'package:assembli/location.dart';
import 'package:assembli/models/course_model.dart';
import 'package:assembli/studentUI/course_attendance.dart';
import 'package:assembli/studentUI/student_create_request.dart';
import 'package:flutter/material.dart';
//import 'package:assembli/location.dart';
import 'package:assembli/globals.dart' as globals;


class StudentCourseHome extends StatefulWidget {
  
  //final String courseName;
  //final int courseNumb;
  final Course course;

  const StudentCourseHome({
    Key? key,
    required this.course,
    //required this.courseName,
    //required this.courseNumb,
  }) : super(key: key);

  @override
  State<StudentCourseHome> createState() => _StudentCourseHomeState();
}

class _StudentCourseHomeState extends State<StudentCourseHome> {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 179, 194, 168),
      title: Text("CS - ${widget.course.cid} ${widget.course.cname}"),

    ),

    body: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children:  <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blue),
                  borderRadius: const BorderRadius.all( Radius.circular(8)),
                ),
                child: Text('${globals.runningUser!.schedule!.length}')
              ),
            ),

             Expanded(
              child:  TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CourseAttendance()),
                  );
                },
                child: const Text('Your Attendance Score')
                
              ), 
            )
          ]
        )
      ),
      ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            Color.fromARGB(255, 179, 194, 168))),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const LocationFinder();
                  },
                ),  (route) => false,
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