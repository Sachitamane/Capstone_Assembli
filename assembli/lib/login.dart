// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:assembli/landing.dart';
import 'package:flutter/services.dart';

//this file creates the login state/appearance

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String textFromFile = "Empty";
  String email = "";
  String userType = "";
  String rNum = "";
  String pass = "";

  getData() async {
    String response;
    response = await rootBundle.loadString('text/credentials.txt');
    setState(() {
      textFromFile = response;
    });
  }

  bool checkLogin() {
    bool access = false;
    var text = textFromFile.replaceAll("\n", ",");
    //print(text);
    var line = text.split(",");

    for (int i = 0; i < line.length; i++) {
      if (((line[i]).toLowerCase()).compareTo((email.toLowerCase())) == 0) {
        if (line[i + 1] == (pass)) {
          access = true;
          userType = line[i + 2];
          rNum = line[i + 3];
        }
      }
    }

    return access;
  }

  TextEditingController myController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
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
                  email = myController.text;
                  pass = passController.text;

                  bool passed = checkLogin();
                  print(passed);
                  //
                  //pushAndRemoveUntil basically opens up the landing page
                  //and removes access to the login page until some time
                  //

                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) {
                  //       return const Landing();
                  //     },
                  //   ),
                  //   (route) => false,
                  // );
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
