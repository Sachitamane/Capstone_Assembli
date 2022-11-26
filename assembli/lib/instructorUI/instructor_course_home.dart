import 'package:assembli/instructorUI/instructor_course_attendance.dart';
import 'package:assembli/instructorUI/instructor_create_request.dart';
import 'package:assembli/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:assembli/location.dart';
import 'package:assembli/globals.dart' as globals;


class InstructorCourseHome extends StatefulWidget {
  //const InstructorCourseHome({Key? key}) : super(key: key);
  final Course course;

  const InstructorCourseHome({
    Key? key,
    required this.course,

  }) : super(key: key);

  @override
  State<InstructorCourseHome> createState() => _InstructorCourseHomeState();
}

class _InstructorCourseHomeState extends State<InstructorCourseHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        title: Text("CS - ${widget.course.cid} ${widget.course.cname}"),
      
      ),

      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children:  <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: const Color.fromARGB(255, 179, 194, 168)),
                      borderRadius: const BorderRadius.all( Radius.circular(8)),
                    ),
                    ///////////////////////////////START HERE
                    child: Text('${globals.runningUser!.attends!.where((element) => element.present == true)
                                                      .where((element) => element.crn == widget.course.crn)
                                                      .length} / ${globals.runningUser!.schedule!
                                                      .where((element) => element.crn == widget.course.crn).length}')
                  ),
                ),

                Expanded(
                  child:  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  InstructorCourseAttendance( attenList: globals.runningUser!.attends!.where((element) => element.crn == widget.course.crn).toList(),)),
                      );
                    },
                    child: const Text('Students present')
                    
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
                    return const InstructorCreateAnnouncements();
                  },
                ),
                (route) => false,
              );
            },
          child: const Text('Request Excused Absence',
              style: TextStyle(color: Colors.white, fontSize: 25)),
        ),
          Center(
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
            )
          )
        ]
      )
    );
    /*return Center(
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
    ));*/
  }
}
