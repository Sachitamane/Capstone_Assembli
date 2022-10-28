// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:assembli/user.dart';

class InstructorCourseHome extends StatefulWidget {
  const InstructorCourseHome({Key? key}) : super(key: key);
  @override
  State<InstructorCourseHome> createState() => _InstructorCourseState();
}

class _InstructorCourseState extends State<InstructorCourseHome> {
  String tmpText = "";
  int classCode = 0;
  bool classOpen = false;
  void generateCode() {
    Random rand = Random();
    classCode = rand.nextInt(9000) + 1000;
  }

  void launchAttendance() {
    if (!classOpen) {
      generateCode();
      final now = DateTime.now();
      String formatter = DateFormat('yMd').format(now);
      tmpText =
          '$formatter,${Courses.courses[Courses.selectedCourse]},true,$classCode';
      print(tmpText);
      _write("openattendance.txt");
      setState(() {
        classOpen = true;
      });
    } else {
      final now = DateTime.now();
      String formatter = DateFormat('yMd').format(now);
      tmpText =
          '$formatter,${Courses.courses[Courses.selectedCourse]},false,$classCode';
      _write("openattendance.txt");
      setState(() {
        classOpen = false;
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
    String code = classCode.toString();
    // ignore: prefer_const_constructors
    return Scaffold(
        body: classOpen
            ? SingleChildScrollView(
                child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(100),
                  child: Text('Class Code : $classCode'),
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
                      launchAttendance();
                    },
                    child: const Text('Open Attendance',
                        style: TextStyle(color: Colors.white, fontSize: 25))),
              ));
  }
}
