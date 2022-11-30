import 'package:assembli/instructorUI/instructor_course_attendance.dart';
import 'package:assembli/instructorUI/instructor_create_announcement.dart';
import 'package:assembli/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:assembli/location/instructor_location.dart';
import 'package:assembli/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assembli/analytics/attendance_analytics.dart';

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
  //controls whether or not the button is open attendance or close attendance
  bool open = false;

  CollectionReference classroom =
      FirebaseFirestore.instance.collection('CourseAuthFactors');

  //used to change attendance button to CLOSE
  void changeToCloseAttendance() {

    setState(() {
        open = true;
    });
  }

  //used to change attendance button to OPEN
  void changeToOpenAttendance() {

    setState(() {
        open = false;
    });
  }

  // updates the open status of the classroom to true
  Future<void> updateOpenStatus() async {
    return classroom.doc(widget.course.crn.toString()).update({
      'open': true
    });
  }

  // updates the open status of the classroom to false
  Future<void> updateCloseStatus() async {
    return classroom.doc(widget.course.crn.toString()).update({
      'open': false
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 179, 194, 168),
          title: Text("CS - ${widget.course.cid} ${widget.course.cname}"),
        ),
        body: Column(children: <Widget>[
          FutureBuilder<DocumentSnapshot>(
                  future: classroom.doc(widget.course.crn.toString()).get(),
                  builder: ((BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      debugPrint("error!");
                    }
                    if (snapshot.hasData && !snapshot.data!.exists) {
                      debugPrint("data exists");
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic>? data =
                          snapshot.data!.data() as Map<String, dynamic>?;
                      open = data?['open'];
                    }
                    return Container();
                  })),
          
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
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(children: <Widget>[
                
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 179, 194, 168)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      //attendance ratio
                      child: Text(
                          '${globals.runningUser!.attends!.where((element) => element.present == true).where((element) => element.crn == widget.course.crn).length} / ${globals.runningUser!.attends!.where((element) => element.crn == widget.course.crn).length}')),
                ),
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InstructorCourseAttendance(
                                    attenList: globals.runningUser!.attends!
                                        .where((element) =>
                                            element.crn == widget.course.crn)
                                        .toList(),
                                  )),
                        );
                      },
                      child: const Text('Students present')),
                )
              ])),
          //OPEN AND CLOSE ATTENDANCE button EDIT MAKE IT OPEN AND CLOSE UI BASED ON CLASSROOM STATUS
          !open ?
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 179, 194, 168))),
              onPressed: () {
                updateOpenStatus();
                changeToCloseAttendance();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LocationSetter(course: widget.course);
                    },
                  ),
                );
              },
              child: const Text('Open Attendance',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          ) :
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 179, 194, 168))),
              onPressed: () {
                updateCloseStatus();
                changeToOpenAttendance();
              },
              child: const Text('Close Attendance',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          ),
          //////////////////////////////////////////////////////////////////START HERE
          // "make announcement" button
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 179, 194, 168))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return InstructorCreateAnnouncements(
                        crn: widget.course.crn,
                      
                      );
                    },
                  ),
                );
              },
              child: const Text('Make Announcement',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          ),
          //////////////////////////////////////////////////////////////////CREATE STUDENT ANALYTICS BUTTON
          // "open attendance" button
          Center(
              child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    Color.fromARGB(255, 179, 194, 168))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return attendanceAnalytics(course: widget.course);
                  },
                ),
              );
            },
            child: const Text('Class Analytics',
                style: TextStyle(color: Colors.white, fontSize: 25)),
          ))

          //end of widget list
        ]));
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
