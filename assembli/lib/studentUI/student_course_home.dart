import 'package:assembli/location/student_location.dart';
import 'package:assembli/models/attendance_model.dart';
import 'package:assembli/models/course_model.dart';
import 'package:assembli/studentUI/student_announcements_page.dart';
import 'package:assembli/studentUI/student_course_attendance.dart';
import 'package:assembli/studentUI/student_create_request.dart';
import 'package:flutter/material.dart';
//import 'package:assembli/location.dart';
import 'package:assembli/globals.dart' as globals;

class StudentCourseHome extends StatefulWidget {
  final Course course;

  const StudentCourseHome({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  State<StudentCourseHome> createState() => _StudentCourseHomeState();
}

class _StudentCourseHomeState extends State<StudentCourseHome> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        //title: Text("CS - ${widget.course.cid} ${widget.course.cname}"),
        title: const Text('Assembli'),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(children: <Widget>[
        //sized box to display the selected course
        const SizedBox(height: 35),
        Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 10),
          child: DefaultTextStyle(
            style: const TextStyle(
                color: Color.fromARGB(255, 123, 123, 123),
                fontSize: 20,
                fontStyle: FontStyle.italic),
            child: Text("CS - ${widget.course.cid} ${widget.course.cname}"),
          ),
        ),

        //divider
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Divider(
            height: 20,
            thickness: 2,
            color: Color.fromARGB(255, 243, 113, 113),
          ),
        ),

        //row widget
        Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(children: <Widget>[
              //attendance ratio
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                  margin: const EdgeInsets.all(20),
                  /* decoration: BoxDecoration(
                border: Border.all(width: 1, color: const Color.fromARGB(255, 179, 194, 168)),
                borderRadius: const BorderRadius.all( Radius.circular(8)),
              ),*/
                  child: Text(
                      '${globals.runningUser!.attends!.where((element) => element.present == true).where((element) => element.crn == widget.course.crn).length} / ${globals.runningUser!.attends!.where((element) => element.crn == widget.course.crn).length}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 91, 90, 90),
                          fontSize: 20))),

              //attendance score button
              Expanded(
                  child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(255, 255, 255, 255))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentCourseAttendance(
                            attenList: globals.runningUser!.attends!
                                .where((element) =>
                                    element.crn == widget.course.crn)
                                .toList())),
                  );
                },
                child: const Text('Attendance Score',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromARGB(255, 91, 90, 90), fontSize: 20)),
              )
                  /*child:  TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  StudentCourseAttendance( 
                        attenList: globals.runningUser!.attends!
                        .where((element) => element.crn == widget.course.crn)
                        .toList()
                      )
                    ),
                  );
                },
                child: const Text('Your Attendance Score')
              ), */
                  )
            ])),

        //log my attendance button
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 179, 194, 168))),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LocationFinder(course: widget.course);
                },
              ),
            );
          },
          child: const Text('Log my Attendance',
              style: TextStyle(color: Colors.white, fontSize: 25)),
        ),

        //divider
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Divider(
            height: 20,
            thickness: 2,
            color: Color.fromARGB(255, 243, 113, 113),
          ),
        ),

        //see announcements button
        SizedBox(
          width: 370,
          height: 33,
          child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    Color.fromARGB(255, 179, 194, 168))),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const StudentAnnouncementsPage();
                  },
                ),
                (route) => false,
              );
            },
            child: const Text('Announcements',
                style: TextStyle(color: Colors.white, fontSize: 25)),
          ),
        ),

        //spacer
        const SizedBox(height: 35),
        //create request button
        SizedBox(
          width: 370,
          height: 33,
          child: ElevatedButton(
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
        ),
      ]));
}
