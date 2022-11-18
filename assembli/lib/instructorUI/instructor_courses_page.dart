import 'package:flutter/material.dart';
import 'package:assembli/instructorUI/instructor_course_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InstructorCoursesPage extends StatefulWidget {
  const InstructorCoursesPage({super.key});

  @override
  State<InstructorCoursesPage> createState() => _InstructorCoursesPageState();
}

class _InstructorCoursesPageState extends State<InstructorCoursesPage> {
  final controller = TextEditingController(); //searchbar controller
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('Course');

  List allCourses = []; //courseCollection.get()

/*
  docToObject(List<dynamic> courses){
      for (var element in courses) {
        var data = element.get(); 
        debugPrint(data.toString());
      }
    
  }

  searchCourse(String query) {
    
  }
*/

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(children: <Widget>[
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
              /////////////////////SEARCH STILL IN PROGRESS
              //onChanged: searchCourse,
            ),
          ),
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

                        // allCourses.add(documentSnapshot);    //primarily for search functionality, not complete
                        //adds all documents returned in the app list of type QueryDocumentSnapshot (subclass od DocumentSnapshot)
                        //basically don't want to query the dDB again just to search each time

                        //debugPrint(allCourses[index].toString());
                        return Card(
                          margin: const EdgeInsets.all(16),
                          child: ListTile(
                              title: Text(documentSnapshot['cname']),
                              subtitle:
                                  Text(documentSnapshot['cid'].toString()),
                              leading: const Icon(
                                  Icons.account_balance_wallet_outlined),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InstructorCourseHome(
                                            courseName:
                                                documentSnapshot['cname'],
                                            courseNumb: documentSnapshot['cid'],
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
