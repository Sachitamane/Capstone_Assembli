import 'package:assembli/courses.dart';
import 'package:flutter/material.dart';

// Log in

void main() {
  runApp(Assembli());
}

class Assembli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,

      //sets login page as homepage ( default i guess )
      home: Login(),
    );
  }
}
