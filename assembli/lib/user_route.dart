import 'package:assembli/instructorUI/instructor_landing.dart';
import 'package:assembli/studentUI/student_landing.dart';
import 'package:assembli/services/dbservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:assembli/globals.dart' as globals;

class UserRoute extends StatefulWidget {
  const UserRoute({super.key});

  @override
  State<UserRoute> createState() => _UserRouteState();
}

class _UserRouteState extends State<UserRoute> {

  Control ctrl = Control(authUser: globals.authUser!);//(authUser: FirebaseAuth.instance.currentUser);
  late Future<bool> configured;
  
  @override 
  void initState() {
    super.initState();
    configured = ctrl.setProfile(globals.authUser!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: configured,  
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

            debugPrint('----------------------------\n');
            debugPrint(globals.authUser!.uid);
            debugPrint(globals.runningUser.toString());
            debugPrint('----------------------------\n');
            debugPrint('----------------------------\n');
            debugPrint('----------------------------\n');
            
            if(globals.runningUser!.type!.compareTo('student') == 0){
              debugPrint('-------------------student landing-------------------');
              return const StudentLanding();
            }
            if(globals.runningUser!.type!.compareTo('instructor') == 0){
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
final _usersCollection = FirebaseFirestore.instance.collection('Users');
  final User? user = FirebaseAuth.instance.currentUser;
  late Future<String>? typeFuture;
  //late Future<AppUser> runningUser;
  late Future<bool> configured;
  Control ctrl = Control();

  @override 
  void initState() {
    super.initState();
    typeFuture = getType();
   // runningUser = ctrl.setProfile(user!);
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
*/