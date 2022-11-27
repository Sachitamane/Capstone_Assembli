//import 'dart:html';   //used for location.dart?

import 'package:assembli/studentUI/student_course_home.dart';
import 'package:flutter/material.dart';
//import 'package:assembli/student_course_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentCoursesPage extends StatefulWidget {
  const StudentCoursesPage({super.key});

  @override
  State<StudentCoursesPage> createState() => _StudentCoursesPageState();
}

class _StudentCoursesPageState extends State<StudentCoursesPage> {
  final controller = TextEditingController();
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('Course');

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(children: <Widget>[
          //search bar : //https://www.youtube.com/watch?v=ZHdg2kfKmjI
          Container(
            margin: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search Courses',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 179, 194, 168))),
              ),
              /////////////////////START HERE LATER
              // onChanged: searchCourse,
            ),
            /////////////////////START HERE LATER
            // onChanged: searchCourse,
          ),

          //may work with better connection or different wifi, try again later
          //ref video for CRUD (Read) db operations https://www.youtube.com/watch?v=n1PM9XcYD5s&list=PL4tcFRTiQTj2BeFQ0e97C0ZQAi8l-HOM4&index=4
          Expanded(
            child: StreamBuilder(
                stream: courseCollection.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              title: Text(documentSnapshot['cname']),
                              subtitle:
                                  Text(documentSnapshot['cid'].toString()),
                              tileColor: Color.fromARGB(255, 241, 241, 241),
                              //leading: const Icon(
                              //Icons.account_balance_wallet_outlined),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentCourseHome(
                                            //constructor (passing course info)
                                            courseName:
                                                documentSnapshot['cname'],
                                            courseNumb: documentSnapshot['cid'],
                                            //student rnum here, somehow pass this throughout entire app
                                          )),
                                );
                              }),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )
        ]),
      );
}
