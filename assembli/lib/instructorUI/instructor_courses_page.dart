import 'package:assembli/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:assembli/instructorUI/instructor_course_home.dart';
import 'package:assembli/globals.dart' as globals;



class InstructorCoursesPage extends StatefulWidget {
  const InstructorCoursesPage({Key? key}) : super(key: key);

  @override
  State<InstructorCoursesPage> createState() => _InstructorCoursesPageState();
}

class _InstructorCoursesPageState extends State<InstructorCoursesPage> {
  
  //optional access to globals
  final AppUser userClone = globals.runningUser!;

  /////////////////////////////////////////////////////
  @override
  void initState(){
    super.initState();
  }
  //////////////////////////////////////////////////////
  //old ui
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("CS - 4366 Senior Capstone Project"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const InstructorCourseHome();
                    },
                  ),
                  (route) => false,
                );
              },
            );
          }),
    );
  }
  */
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Column(
      children: <Widget>[
        //list of courses pertaining to current appuser
        Expanded(
          child: ListView.builder(
            itemCount: globals.runningUser!.schedule!.length,
            itemBuilder:(context, index){
              return Card(
                margin:  const EdgeInsets.all(16),
                child: ListTile(
                  title: Text(globals.runningUser!.schedule![index].cname.toString()),
                  subtitle: Text(globals.runningUser!.schedule![index].cid.toString()),
                  //title: Text(userClone.schedule![index].cname.toString()),
                  //subtitle: Text(userClone.schedule![index].cid.toString()),
                  leading: const Icon(Icons.account_balance_wallet_outlined),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InstructorCourseHome(
                          //course: userClone.schedule![index]
                          course: globals.runningUser!.schedule![index]
                        )),
                      );
                  }
                ),
              );
            }
          )
        )
      ]
    ),
  );
}

