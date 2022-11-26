//import 'dart:html';   //used for location.dart?
import 'package:assembli/models/user_model.dart';
import 'package:assembli/studentUI/student_course_home.dart';
import 'package:flutter/material.dart';
import 'package:assembli/globals.dart' as globals;

class StudentCoursesPage extends StatefulWidget {
  const StudentCoursesPage({super.key});

  @override
  State<StudentCoursesPage> createState() => _StudentCoursesPageState();
}


class _StudentCoursesPageState extends State<StudentCoursesPage> {

  //optional access to globals
  final AppUser userClone = globals.runningUser!;

  /////////////////////////////////////////////////////
  @override
  void initState(){
    super.initState();
  }
  //////////////////////////////////////////////////////
  
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
                        builder: (context) => StudentCourseHome(
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

//old builder from db call
/*Expanded(
        child: StreamBuilder(
          stream: courseCollection.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
            if(streamSnapshot.hasData){
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index){
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(16),
                    child: ListTile(
                      title: Text(documentSnapshot['cname']),
                      subtitle: Text(documentSnapshot['cid'].toString()),
                      leading: const Icon(Icons.account_balance_wallet_outlined),
                      onTap: () {
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StudentCourseHome(
                            //constructor (passing course info)
                            courseName: documentSnapshot['cname'],
                            courseNumb: documentSnapshot['cid'],
                            //student rnum here, somehow pass this throughout entire app
                          )),
                        );
                      }
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator(),);
          }
        ),
      )*/
