//import 'dart:html';   //used for location.dart?

import 'package:assembli/models/user_model.dart';
import 'package:assembli/studentUI/student_course_home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assembli/globals.dart' as globals;

//missing connection to student_course_home.dart page upon pressing links

class StudentCoursesPage extends StatefulWidget {
  const StudentCoursesPage({super.key});

  @override
  State<StudentCoursesPage> createState() => _StudentCoursesPageState();
}


class _StudentCoursesPageState extends State<StudentCoursesPage> {
  final controller = TextEditingController();
  final CollectionReference courseCollection = FirebaseFirestore.instance.collection('Course');
  final AppUser dupeUser = globals.runningUser!;  
  

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

        //search bar : //https://www.youtube.com/watch?v=ZHdg2kfKmjI
        Container(
          margin: const EdgeInsets.all(16),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search Courses',
              border: OutlineInputBorder(
                borderRadius:  BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color.fromARGB(255, 179, 194, 168))
              ),
            ),
            //////////////////START HERE LATER
            // onChanged: searchCourse, 
          ),
        ),

        //list of courses pertaining to current appuser
        Expanded(
          child: ListView.builder(
            itemCount: globals.runningUser!.schedule!.length,
            itemBuilder:(context, index){
              return Card(
                margin:  const EdgeInsets.all(16),
                child: ListTile(
                  //title: Text(globals.runningUser!.schedule![index].cname.toString()),
                  title: Text(dupeUser.schedule![index].cname.toString()),
                  //subtitle: Text(globals.runningUser!.schedule![index].cid.toString()),
                  subtitle: Text(dupeUser.schedule![index].cid.toString()),
                  leading: const Icon(Icons.account_balance_wallet_outlined),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentCourseHome(
                          course: dupeUser.schedule![index]
                            //courseName: globals.runningUser!.schedule![index].cname,
                            //courseNumb: globals.runningUser!.schedule![index].cid,
                            
                            //courseName: dupeUser.schedule![index].cname,
                            //courseNumb: dupeUser.schedule![index].cid,
                            //student rnum here, somehow pass this throughout entire app
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
