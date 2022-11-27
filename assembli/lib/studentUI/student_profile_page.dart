import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  // Log out button, redirects to login.dart
  //login also needs to close the firebase instance
      //might link it to the starter instance on main page
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 179, 194, 168))),
        onPressed: () => FirebaseAuth.instance.signOut(),
        child: const Text('Log Out',style: TextStyle(color: Colors.white, fontSize: 25)),
      )
    );
  }
}
