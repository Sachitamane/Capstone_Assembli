// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:assembli/student_landing.dart';
import 'package:assembli/instructor_landing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:assembli/user.dart';

//this file creates the login state/appearance

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String textFromCredentialsFile = "";
  String textFromRosterFile = "";
  String textFromCoursesFile = "";
  String tmpText = "";
  String emailIn = "";
  String passIn = "";
  String rNum = "";
  String userType = "";

  bool checkLogin() {
    bool access = false;
    var text = textFromCredentialsFile.replaceAll("\n", ",");
    var line = text.split(",");

    for (int i = 0; i < line.length; i++) {
      if (((line[i]).toLowerCase()).compareTo((emailIn.toLowerCase())) == 0) {
        if (line[i + 1] == (passIn)) {
          access = true;
          rNum = line[i + 3];
          User.rNum = rNum;
          userType = line[i + 2];
          User.userType = userType;
          User.email = emailIn;
        }
      }
    }

    return access;
  }

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  final myController = TextEditingController();
  final passController = TextEditingController();

  void getData(String fileName) async {
    if (fileName == "credentials.txt") {
      textFromCredentialsFile = await _read(fileName);
      if (textFromCredentialsFile == "") {
        textFromCredentialsFile = await _read(fileName);
      }
    } else if (fileName == "roster.txt") {
      textFromRosterFile = await _read(fileName);
      if (textFromRosterFile == "") {
        textFromRosterFile = await _read(fileName);
      }
    } else if (fileName == "courses.txt") {
      textFromCoursesFile = await _read(fileName);
      if (textFromCoursesFile == "") {
        textFromCoursesFile = await _read(fileName);
      }
    }
  }

  void setCourseData() {
    var text = textFromCoursesFile.replaceAll("\n", ",Next");
    var line = text.split(",");
    var text1 = textFromRosterFile.replaceAll("\n", ",Next,");
    var line1 = text1.split(",");
    List<String> courses = [];
    Courses.courseInfo = [];
    Courses.courses = [];

    rNum = rNum.substring(0, rNum.length - 1);
    if (userType == "Student") {
      bool flag = true;
      int j = 3;
      for (int i = 0; i < line1.length; i++) {
        if (line1[i].compareTo(rNum) == 0) {
          while ((i + j < line1.length && flag)) {
            if (line1[i + j] != "Next") {
              Courses.courses.add(line1[i + j]);
              courses.add(line1[i + j]);
              j++;
            } else {
              flag = false;
            }
          }
        }
      }
      for (int k = 0; k < line.length; k++) {
        for (int l = 0; l < courses.length; l++) {
          if (line[k] == courses[l].substring(0, courses[l].length - 1)) {
            Courses.courseInfo
                .add('${line[k - 2]}-${line[k - 1]} ${line[k - 3]}');
          }
        }
      }
    } else {
      for (int i = 0; i < line.length; i++) {
        if (line[i] == rNum) {
          Courses.courses.add(line[i - 2]);
          Courses.courseInfo
              .add('${line[i - 4]}-${line[i - 3]} ${line[i - 5]}');
        }
      }
    }
  }

  // Clean up the controller
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
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
    return text;
  }

  @override
  Widget build(BuildContext context) {
    getData("credentials.txt");
    getData("roster.txt");
    getData("courses.txt");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    //used to be Container
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/assembliLogo.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                // Get user input
                controller: myController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid ttu email id'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 45.0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 179, 194, 168),
                  borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(255, 179, 194, 168))),
                onPressed: () {
                  emailIn = myController.text;
                  passIn = passController.text;
                  bool access = checkLogin();
                  if (access) {
                    setCourseData();
                    if (userType == "Student") {
                      Timer(Duration(seconds: 5), () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return StudentLanding();
                            },
                          ),
                          (route) => false,
                        );
                      });
                    } else {
                      Timer(Duration(seconds: 5), () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return InstructorLanding();
                            },
                          ),
                          (route) => false,
                        );
                      });
                    }
                  }
                  // User is neither student or instructor
                  // - NOT in our database/txtFile
                  else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const Login();
                        },
                      ),
                      (route) => false,
                    );
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 85,
            ),
            const Text('Having trouble logging in? Contact your Admin for help')
          ],
        ),
      ),
    );
  }
}
