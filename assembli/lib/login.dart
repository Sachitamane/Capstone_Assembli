// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:assembli/student_landing.dart';
import 'package:assembli/instructor_landing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';

//this file creates the login state/appearance

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String textFromFile = "";
  String tmpText = "";
  String emailIn = "";
  String passIn = "";
  String rNum = "";
  String userType = "";
  // Create controller to retrive the user input
  bool checkLogin() {
    bool access = false;
    var text = textFromFile.replaceAll("\n", ",");
    //print(text);
    var line = text.split(",");

    for (int i = 0; i < line.length; i++) {
      if (((line[i]).toLowerCase()).compareTo((emailIn.toLowerCase())) == 0) {
        if (line[i + 1] == (passIn)) {
          access = true;
          rNum = line[i + 3];
          userType = line[i + 2];
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

  void getData() async {
    textFromFile = await _read();
    if (textFromFile == "") {
      textFromFile = await _read();
    }
  }

  // Clean up the controller
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  _write() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    tmpText = await getFileData("text/credentials.txt");
    final File file = File('${directory.path}/Credentials.txt');
    await file.writeAsString(tmpText, flush: true);
  }

  Future<String> _read() async {
    String text = "";
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/Credentials.txt');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    if (text == "") {
      _write();
    }
    //print(text);
    return text;
  }

  @override
  Widget build(BuildContext context) {
    //getDir();
    //_write("Newest Email\n");
    getData();
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
                  // Student Landing
                  //print(textFromFile);
                  emailIn = myController.text;
                  passIn = passController.text;
                  bool access = checkLogin();

                  if (access) {
                    if (userType == "Student") {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const StudentLanding();
                          },
                        ),
                        (route) => false,
                      );
                    } else {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const InstructorLanding();
                          },
                        ),
                        (route) => false,
                      );
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
