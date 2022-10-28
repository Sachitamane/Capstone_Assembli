// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:assembli/user.dart';
import 'package:assembli/location.dart';

class InstructorCourseHome extends StatefulWidget {
  const InstructorCourseHome({Key? key}) : super(key: key);
  @override
  State<InstructorCourseHome> createState() => _InstructorCourseState();
}

class _InstructorCourseState extends State<InstructorCourseHome> {
  String tmpText = "";
  String classCode = "";
  bool classOpen = false;

  void launchAttendance() {
    if (!classOpen) {
      final now = DateTime.now();
      String formatter = DateFormat('yMd').format(now);
      classCode = Courses.code;
      tmpText =
          '$formatter,${Courses.courses[Courses.selectedCourse]},true,$classCode,${Courses.lat},${Courses.long}';
      print(tmpText);
      _write("openattendance.txt");
    } else {
      final now = DateTime.now();
      String formatter = DateFormat('yMd').format(now);
      tmpText =
          '$formatter,${Courses.courses[Courses.selectedCourse]},false,$classCode,${Courses.lat},${Courses.long}';
      _write("openattendance.txt");
      setState(() {
        classOpen = false;
        Courses.classOpen = false;
      });
    }
  }

  _write(String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileName');
    await file.writeAsString(tmpText, flush: true);
  }

  @override
  Widget build(BuildContext context) {
    classOpen = Courses.classOpen;
    String code = classCode;
    // ignore: prefer_const_constructors
    return Scaffold(
        body: classOpen
            ? SingleChildScrollView(
                child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(100),
                  child: Text('Class Code : ${Courses.code}'),
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 179, 194, 168))),
                    onPressed: () {
                      launchAttendance();
                    },
                    child: const Text('Close Attendance',
                        style: TextStyle(color: Colors.white, fontSize: 25))),
              ]))
            : Center(
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 179, 194, 168))),
                    onPressed: () {
                      // classOpen = true;
                      Timer(Duration(seconds: 45), () {
                        launchAttendance();
                      });
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
                        style: TextStyle(color: Colors.white, fontSize: 25))),
              ));
  }
}
