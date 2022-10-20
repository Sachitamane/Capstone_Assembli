import 'package:assembli/login.dart';
import 'package:flutter/material.dart';

// Log in

void main() {
  runApp(const Assembli());
}

class Assembli extends StatelessWidget {
  const Assembli({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Login(),
    );
  }
}
