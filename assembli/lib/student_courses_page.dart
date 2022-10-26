import 'package:flutter/material.dart';
import 'package:assembli/student_course_home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:assembli/user.dart';
import 'dart:async';

//class holds basis for courses destination;
//will work similar to landing, linking other pages/states
//(linked from navigationBar destination in landing.dart)

class StudentCoursesPage extends StatelessWidget {
  const StudentCoursesPage({Key? key}) : super(key: key);

  //@override
  //Widget build(BuildContext context) {
  //return const Center(
  //  child: Text("Courses Page"),
  //);
  //}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ListView.builder",
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        // home : new ListViewBuilder(),  NO Need To Use Unnecessary New Keyword
        home: ListViewBuilder());
  }
}

class ListViewBuilder extends StatelessWidget {
  ListViewBuilder({Key? key}) : super(key: key);
  String courseNum = "";
  String crn = "";
  String courseName = "";
  String courseSection = "";
  String textFromRosterFile = "";
  String textFromCoursesFile = "";
  String tmpText = "";
  String buttonTxt = "";
  List<String> courses = [];

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  _write(String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    tmpText = await getFileData("text/$fileName");
    final File file = File('${directory.path}/$fileName');
    await file.writeAsString(tmpText, flush: true);
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
      _write(fileName);
    }
    //print(text);
    return text;
  }

  Future<String> getData(String fileName) async {
    String text = "";
    if (fileName == "roster.txt") {
      text = await _read(fileName);
      if (text == "") {
        text = await _read(fileName);
      }
    } else {
      text = await _read(fileName);
      if (text == "") {
        text = await _read(fileName);
      }
    }
    return text;
  }

  void getButtonText() async {
    textFromCoursesFile = await getData("courses.txt");
    textFromRosterFile = await getData("roster.txt");

    String rNum = User.rNum.substring(0, User.rNum.length - 1);
    var text = textFromCoursesFile.replaceAll("\n", ",Next,");
    var line = text.split(",");
    var text1 = textFromRosterFile.replaceAll("\n", ",Next,");
    var line1 = text1.split(",");
    bool flag = true;
    int j = 3;
    for (int i = 0; i < line1.length; i++) {
      if (line1[i].compareTo(rNum) == 0) {
        while ((i + j < line1.length && flag)) {
          if (line1[i + j] != "Next") {
            courses.add(line1[i + j]);
            j++;
          } else {
            flag = false;
          }
        }
      }
    }
  }

  Widget delayedDisplay(BuildContext context) {
    getButtonText();
    courses.add("12345");
    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text("CS - 4366 Senior Capstone Project"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const StudentCourseHome();
                    },
                  ),
                  (route) => false,
                );
              },
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // getButtonText();
    // courses.add("12345");
    courses = Courses.courseInfo;
    return Scaffold(
      body: ListView.builder(
          itemCount: Courses.courses.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(courses[index]),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const StudentCourseHome();
                    },
                  ),
                  (route) => false,
                );
              },
            );
          }),
    );
  }
}
