import 'package:flutter/material.dart';

//class holds basis for profile destination;
//will work similar to landing, linking other pages/states
//(linked from navigationBar destination in landing.dart)

/*class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  // Log out button, redirects to login.dart
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 179, 194, 168))),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const Login();
            },
          ),
        );
      },
      child: const Text('Log Out',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    ));
  }
}*/

class StudentCourseHome extends StatelessWidget {
  const StudentCourseHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Center(
        child: ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 179, 194, 168))),
      onPressed: () {},
      child: const Text('Log my Attendance',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    ));
  }
}
