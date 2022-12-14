import 'package:flutter/material.dart';
import 'package:assembli/login.dart';

//class holds basis for profile destination;
//will work similar to landing, linking other pages/states
//(linked from navigationBar destination in landing.dart)

class InstructorProfilePage extends StatelessWidget {
  const InstructorProfilePage({Key? key}) : super(key: key);

  // Log out button, redirects to login.dart
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 179, 194, 168))),
      onPressed: () {
          Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const Login();
                        },
                      ),
                      (route) => false,
                    );
          },
      child: const Text('Log Out',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    ));
  }
}
