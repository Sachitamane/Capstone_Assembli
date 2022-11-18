import 'package:flutter/material.dart';
import 'package:assembli/studentUI/student_landing.dart';
import 'package:assembli/instructorUI/instructor_landing.dart';

//this file creates the login state/appearance

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Create controller to retrive the user input
  final myController = TextEditingController();
  String userEmail = "";

  // Clean up the controller
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
            const Padding(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 45.0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
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
                  if (myController.text == "student") {
                    //
                    //pushAndRemoveUntil basically opens up the landing page
                    //and removes access to the login page until some time
                    //
                    userEmail = myController.text;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return StudentLanding(passedEmail: userEmail);
                        },
                      ),
                      (route) => false,
                    );
                  }

                  // Instructor Landing
                  else if (myController.text == "instructor") {
                    userEmail = myController.text;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return InstructorLanding(
                            passedEmail: userEmail,
                          );
                        },
                      ),
                      (route) => false,
                    );
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
