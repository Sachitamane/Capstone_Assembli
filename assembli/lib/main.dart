import 'package:assembli/instructorUI/instructor_landing.dart';
import 'package:assembli/login.dart';
//import 'package:assembli/studentUI/student_landing.dart';
import 'package:assembli/user_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// Start of the app running

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Assembli());
}

final navigatorKey = GlobalKey<NavigatorState>();
//String? uType;


class Assembli extends StatelessWidget {
  const Assembli({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: true,
      home: const MainPage(),
    );
  }
}

//originally stateless
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),   //returns either a valid user or null; depends on signIn response
                                                          //see login.dart Ln 199, Col 7 <within Future signIn() method
      builder: (context, snapshot) {                      //snapshot is the returned result of authStateChanges(),
        if(snapshot.hasData ){
        //loading toggle here or within uRoute class
          return UserRoute(user: snapshot.data!,);//(identifier: snapshot.data!.uid);
          //return const InstructorLanding();
          
        } else{
          return const Login();
        }
      } 
    ),
    );
}
