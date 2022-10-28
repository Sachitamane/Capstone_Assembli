import 'dart:async';

import 'package:flutter/material.dart';
import 'package:assembli/location.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:assembli/user.dart';
import 'package:intl/intl.dart';

class StudentCourseHome extends StatelessWidget {
  StudentCourseHome({Key? key}) : super(key: key);

  String textFromFile = "";
  String attendanceTxt = "";
  String tmpText = "";
  bool isOpen = false;

  Future<void> getData(String fileName) async {
    if (fileName == "openattendance.txt") {
      textFromFile = await _read(fileName);
      if (textFromFile == "") {
        textFromFile = await _read(fileName);
      }
    } else if (fileName == "attendance.txt") {
      attendanceTxt = await _read(fileName);
      if (attendanceTxt == "") {
        attendanceTxt = await _read(fileName);
      }
    }
  }

  _write(String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileName');
    if (fileName == "attendance.txt") {
      final now = DateTime.now();
      String date = DateFormat('yMd').format(now);
      tmpText =
          'present,${User.rNum},$date,${Courses.courses[Courses.selectedCourse]}';
      await file.writeAsString(tmpText, flush: true);
      await getData("attendance.txt");
      print(attendanceTxt);
    } else {
      tmpText = "";
      await file.writeAsString(tmpText, flush: true);
    }
  }

  Future<String> _read(String fileName) async {
    String text = "";
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$fileName');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    if (text == "") {
      _write("openattendance.txt");
    }
    return text;
  }

  Future<void> checkOpen() async {
    await getData("openattendance.txt");
    final now = DateTime.now();
    String date = DateFormat('yMd').format(now);
    String course = Courses.courses[Courses.selectedCourse];
    String text = textFromFile.replaceAll("\n", ",");
    var line = text.split(',');
    for (int i = 0; i < line.length; i++) {
      if (line[i] == date) {
        if (line[i + 1] == course.substring(0, course.length - 1)) {
          if (line[i + 2] == "true") {
            Courses.classOpen = true;
            Courses.code = line[i + 3];
            Courses.lat = line[i + 4];
            Courses.long = line[i + 5];
          } else {
            Courses.classOpen = false;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    isOpen = Courses.classOpen;
    if (Courses.present) {
      _write('attendance.txt');
    }
    return Center(
        child: ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 179, 194, 168))),
      onPressed: () {
        checkOpen();
        Timer(Duration(seconds: 1), () {
          isOpen = Courses.classOpen;
          if (isOpen) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const LocationFinder();
                },
              ),
              (route) => false,
            );
          } else {
            print("not open");
          }
        });
      },
      child: const Text('Log my Attendance',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    ));
  }
}
