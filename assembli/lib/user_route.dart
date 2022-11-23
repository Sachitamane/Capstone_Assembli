import 'package:assembli/instructorUI/instructor_landing.dart';
import 'package:assembli/models/course_model.dart';
import 'package:assembli/models/user_model.dart';
import 'package:assembli/studentUI/student_landing.dart';
import 'package:assembli/services/dbservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class UserRoute extends StatefulWidget {
  final User user;      //instance of user w/in FirebaseAuthentication class; 
                        //different properties from app's user model class <AppUser>
  
  const UserRoute({
    Key? key,
    required this.user
  }) : super(key: key);
  
  //const UserRoute({super.key});

  @override
  State<UserRoute> createState() => _UserRouteState();
}

class _UserRouteState extends State<UserRoute> {

  Control ctrl = Control();
  
  late Future<String> typeFuture;
  late Future<AppUser> currUser;
  bool student = false;  

  @override 
  void initState() {
    super.initState();
    // typeFuture = dbConnect.getType(widget.user.uid);    //_getType();

  }

//this method was replaced by Control's getType method in order to make retrieval of info more organized
/*  Future<String> _getType() async {
    String temp='';
    await _usersCollection.doc(widget.user.uid).get().then((DocumentSnapshot snapshot) {
        temp = snapshot.get('type');
      });
      debugPrint('temp equals $temp in getType method');
    return temp;
  }
*/

  @override
  Widget build(BuildContext context) {
      
    //return type? const StudentLanding() : const InstructorLanding();
    return FutureBuilder(
      //future: typeFuture,  
      future: currUser,
      builder: (context, snapshot) {

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(child: Text('no connection to db'));
          case ConnectionState.active:
          case ConnectionState.waiting:

                                    
            //////////////////////////////////////////////////////////////////return const LoadingPage();
            return const Center(    //look into using an Align widget later
              child: SpinKitPianoWave(
                duration: Duration(seconds: 3),
                color: Color.fromARGB(255, 179, 194, 168)), 
            );       
            

          case ConnectionState.done:
            if(snapshot.data!.type?.compareTo('student') == 0){
              return const StudentLanding();
            }
            if(snapshot.data!.type?.compareTo('instructor') ==0){
              return const InstructorLanding();
            }
            else{
              return const Center(child: Text('error'));
            }

            //return student? const StudentLanding() : const InstructorLanding();
            
          default:
            return const Center(child: Text('missing document'));
        }
      }
    );
  }
}
