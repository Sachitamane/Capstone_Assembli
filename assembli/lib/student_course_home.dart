import 'package:flutter/material.dart';
import 'package:assembli/location.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:assembli/user.dart';
import 'package:intl/intl.dart';

class StudentCourseHome extends StatelessWidget {
  StudentCourseHome({Key? key}) : super(key: key);

  String textFromFile = "";
  String tmpText = "";
  bool isOpen = true;

  Future<void> getData() async {
    textFromFile = await _read();
    if (textFromFile == "") {
      textFromFile = await _read();
    }
  }

  _write() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/openattendance.txt');
    await file.writeAsString(tmpText, flush: true);
  }

  Future<String> _read() async {
    String text = "";
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/openattendance.txt');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    if (text == "") {
      _write();
    }
    return text;
  }

  Future<void> checkOpen() async {
    await getData();
    final now = DateTime.now();
    String date = DateFormat('yMd').format(now);
    String course = Courses.courses[Courses.selectedCourse];
    String text = textFromFile.replaceAll("\n", ",");
    var line = text.split(',');
    for (int i = 0; i < line.length; i++) {
      if (line[i] == date) {
        if (line[i + 1] == course.substring(0, course.length - 1)) {
          if (line[i + 2] == "true") {
            isOpen = true;
          } else {
            isOpen = false;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Center(
        child: ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 179, 194, 168))),
      onPressed: () {
        //checkOpen();
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
      },
      child: const Text('Log my Attendance',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    ));
  }
}
