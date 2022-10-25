import 'package:flutter/material.dart';
import 'package:assembli/login.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  int count = 0;

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
}


//ref to change (moved from stateless to stateful)//////////////////////////////////
/*
class StudentProfilePage extends StatelessWidget {
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
}
*/
