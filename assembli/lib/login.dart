// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:assembli/studentUI/student_landing.dart';
import 'package:assembli/instructorUI/instructor_landing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assembli/user.dart';

//this file creates the login state/appearance

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Create controller to retrive the user input
  final myController = TextEditingController();
  final passControllers = TextEditingController();
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('Users');
  bool isValid = false;
  String email = "";
  String pass = "";
  // Clean up the controller
  void validateUser() {
    for (int i = 0; i < User.emails.length; i++) {
      if (User.emails[i] == email) {
        if (User.passwords[i] == pass) {
          isValid = true;
          User.type = User.types[i];
          User.rnum = User.rNums[i];
        }
      }
    }
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            StreamBuilder(
                stream: courseCollection.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    int index = streamSnapshot.data!.docs.length;
                    if (User.emails.isEmpty) {
                      for (int i = 0; i < index; i++) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[i];
                        User.emails.add(documentSnapshot['email']);
                        User.passwords.add(documentSnapshot['password']);
                        User.rNums.add(documentSnapshot['rnum']);
                        User.types.add(documentSnapshot['type']);
                      }
                    }
                  }
                  return const Center();
                }),
            Padding(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 45.0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                controller: passControllers,
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
                  print(User.emails);
                  email = myController.text;
                  pass = passControllers.text;
                  validateUser();
                  if (isValid) {
                    if (User.type == "student") {
                      //
                      //pushAndRemoveUntil basically opens up the landing page
                      //and removes access to the login page until some time
                      //

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const StudentLanding();
                          },
                        ),
                        (route) => false,
                      );
                    }

                    // Instructor Landing
                    else if (User.type == "instructor") {
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

                    // User is neither student or instructor
                    // - NOT in our database/txtFile
                  } else {
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
