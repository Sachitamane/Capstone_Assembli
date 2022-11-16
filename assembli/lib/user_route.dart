import 'package:assembli/instructorUI/instructor_landing.dart';
import 'package:assembli/login.dart';
import 'package:assembli/main.dart';
import 'package:assembli/studentUI/student_landing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final collection = FirebaseFirestore.instance.collection('Users');
final user = FirebaseAuth.instance.currentUser!;

class UserRoute extends StatefulWidget {


  /*
  final String uid;        //identifier for document within firestore collection
  
  const UserRoute({
    Key? key,
    required this.uid,
    
  }) : super(key: key);
  */
  const UserRoute({super.key});

  //I can choose to gather all database info needed based on
  //this uid via Users and create objects/class instances, or I can just stick to
  //routing into differing landings

  @override
  State<UserRoute> createState() => _UserRouteState();
}

class _UserRouteState extends State<UserRoute> {
//widget.uid is how you will obtain information set in UserRoute into _UserRoute
  
  @override
  Widget build(BuildContext context) {
    return  Center(child: Text(user.uid)); //const Login();
  }
}
/*return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('events')
          .doc(widget.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if(snapshot.hasData){
              final DocumentSnapshot docSnapshot = snapshot.data!;
              type =  docSnapshot['type'];
            }
          //return const Center(child: CircularProgressIndicator(),);
          return utype(type);
      },
    );*/