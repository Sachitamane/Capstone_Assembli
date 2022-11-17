import 'package:assembli/instructorUI/instructor_course_home.dart';
import 'package:flutter/material.dart';
//import 'package:assembli/Instructor_course_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assembli/user.dart';
//missing connection to Instructor_course_home.dart page upon pressing links

class InstructorCoursesPage extends StatefulWidget {
  const InstructorCoursesPage({super.key});

  @override
  State<InstructorCoursesPage> createState() => _InstructorCoursesPageState();
}

class _InstructorCoursesPageState extends State<InstructorCoursesPage> {
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
                        print(documentSnapshot['rnum']);
                        if (documentSnapshot['rnum'].toString() == User.rnum) {
                          return ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 179, 194, 168))),
                            onPressed: () {
                              User.cname = documentSnapshot['cname'];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return InstructorCourseHome();
                                  },
                                ),
                              );
                              // Navigator.pushAndRemoveUntil(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) {
                              //       return const InstructorCourseHome();
                              //     },
                              //   ),
                              //   (route) => false,
                              // );
                            },
                            child: Card(
                              margin: const EdgeInsets.all(16),
                              child: ListTile(
                                title: Text(documentSnapshot['cname']),
                                subtitle: const Text('dubbb'),
                              ),
                            ),
                          );
                          // Card(
                          //   margin: const EdgeInsets.all(16),
                          //   child: ListTile(
                          //     title: Text(documentSnapshot['cname']),
                          //     subtitle: const Text('dubbb'),
                          //   ),

                          // );
                        } else {
                          return Center();
                        }
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
