import 'package:assembli/instructorUI/instructor_landing.dart';
import 'package:assembli/login.dart';
import 'package:assembli/studentUI/student_landing.dart';
import 'package:assembli/user_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class Assembli extends StatelessWidget {
  const Assembli({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: true,
      /*
      initialRoute: '/',
      routes: {
        '/' : (context) => const MainPage(),
        '/sUser' :(context) => const StudentLanding(),
        '/iUser' :(context) => const InstructorLanding()
      },
      */
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData ){
/*
          final collection = FirebaseFirestore.instance.collection('Users');
          final user = FirebaseAuth.instance.currentUser!;
          String type = '';
          //DocumentSnapshot<Map<String, dynamic>>
          var  docPull = collection
                          .doc(user.uid)
                          .get().
                          then((DocumentSnapshot docSnapshot) {
                            //navigatorKey.currentState!.pushReplacementNamed()
                            type  = docSnapshot.get('type');
                            }
                          );
                          
          if (type.compareTo('student') == 0){
            return const StudentLanding();
          }
          if (type.compareTo('instructor') == 0){
            return const InstructorLanding();
          }
          //else type not retrieved

          return const UserRoute();//(uid: snapshot.data!.uid);


*/
          return const StudentLanding();
        } else{
          return const Login();
        }
      } 
    ),
    );

/*
  Future <String> type(String docID) async {
    //User? user = FirebaseAuth.instance.currentUser;
    String temp = '';
   // var collection = FirebaseFirestore.instance.collection('Users');
    var docSnapshot = FirebaseFirestore.instance
      .collection('Users')
      .doc(docID)   //identifier for link between authentication and Users collection .type field
      .get()//;
      //Map<String, dynamic> data = docSnapshot.data!();
      .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if(documentSnapshot.get("type") == "instructor"){
            temp = "instructor";
          }
          if(documentSnapshot.get("type") == "student"){
            temp = 'student';
          }
        }
        //ideally you'd never get to this else because the snapshot has to exist
        //to even enter this function , but it a required fail-safe
        else {
          debugPrint('Document does not exist on the database, see admin for help');
        }
       }
      );
    debugPrint('temp equals $temp');
    return temp;
  }*/
}
