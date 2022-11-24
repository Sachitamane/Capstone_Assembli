/*
import 'package:assembli/instructorUI/instructor_landing.dart';
import 'package:assembli/login.dart';
import 'package:assembli/main.dart';
import 'package:assembli/studentUI/student_landing.dart';
*/
import 'package:assembli/instructorUI/instructor_landing.dart';
import 'package:assembli/studentUI/student_landing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class UserRoute extends StatefulWidget {
  /*final User user;
  
  const UserRoute({
    Key? key,
    required this.user
  }) : super(key: key);
  */
  const UserRoute({super.key});

  @override
  State<UserRoute> createState() => _UserRouteState();
}

class _UserRouteState extends State<UserRoute> {

  final _usersCollection = FirebaseFirestore.instance.collection('Users');
  final User? user = FirebaseAuth.instance.currentUser;
  late Future<String>? typeFuture;
  bool student = false;

  @override 
  void initState() {
    super.initState();
    typeFuture = getType();
  }

  Future<String> getType() async {
    String temp='';
    await _usersCollection.doc(user!.uid).get().then((DocumentSnapshot snapshot) {
        temp = snapshot.get('type');
      });
      debugPrint('temp equals $temp in getType method');
    return temp;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: typeFuture,  
      builder: (context, snapshot) {

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('none');
          case ConnectionState.active:
          case ConnectionState.waiting:
            //debugPrint(snapshot.data!);
            return const Center(
              child: SpinKitPianoWave(
              color: Color.fromARGB(255, 179, 194, 168)),
              );
          case ConnectionState.done:
            if(snapshot.data!.compareTo('student') ==0){
              debugPrint('-------------------student landing-------------------');
              return const StudentLanding();
            }
            if(snapshot.data!.compareTo('instructor') ==0){
              debugPrint('-------------------instructor landing-------------------');
              return const InstructorLanding();
            }
            else{
              return const Center(child: Text('error'));
            }
            
          default:
            return const Center(child: Text('missing document'));
        }
      }
    );
  }
    

}

/*
Expanded(
          child: StreamBuilder(
            stream: usersCollection.doc(user.uid).snapshots(),
            builder:(context, snapshot) {
              if(snapshot.hasData){
                if(snapshot.data!['type'] == 'student'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const  StudentLanding()),
                  );
                }
                if(snapshot.data!['type'] == 'instructor'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const  InstructorLanding()),
                  );
                } 
              }
              //create an error page to replace this return,
              //ideally you'll never get here unless it's an error
              return const StudentLanding();    
            },
            
          ),
        )
*/