import 'package:assembli/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// Start of the app running

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Assembli());
}
//may change to statefulWidget, leave for now
class Assembli extends StatelessWidget {
  const Assembli({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      //future routing would start here
      home: Login(),
    );
  }
}
