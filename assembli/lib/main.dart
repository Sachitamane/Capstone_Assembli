import 'package:assembli/login.dart';
import 'package:assembli/user_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Assembli());
}

final navigatorKey = GlobalKey<NavigatorState>();         //used in login.dart => signIn()

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

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),   //authStateChanges listener returns either a valid user or null
                                                          //depends on signIn response
      builder: (context, snapshot) {                      //snapshot is the returned result of authStateChanges(),
        if(snapshot.hasData ){
          return UserRoute(user: snapshot.data!);        //routing /loading page          
        } else{
          return const Login();
        }
      } 
    ),
    );
}
