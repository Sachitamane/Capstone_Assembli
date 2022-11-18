import 'package:assembli/studentUI/student_course_home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//missing connection to student_course_home.dart page upon pressing links
//want to make the back w/ a back button
//and pass data from ontap to student_course_home.dart, preferably consistent
//with the database
class StudentCoursesPage extends StatefulWidget {
  final String passedEmail;
  const StudentCoursesPage({Key? key, required this.passedEmail})
      : super(key: key);

  @override
  State<StudentCoursesPage> createState() => _StudentCoursesPageState();
}

class _StudentCoursesPageState extends State<StudentCoursesPage> {
  final controller = TextEditingController(); //searchbar controller
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('Course');

  List allCourses = [];
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
              /////////////////////SEARCH STILL IN PROGRESS
              //onChanged: searchCourse,
            ),
          ),

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

                        // allCourses.add(documentSnapshot);    //primarily for search functionality, not complete
                        //adds all documents returned in the app list of type QueryDocumentSnapshot (subclass od DocumentSnapshot)
                        //basically don't want to query the dDB again just to search each time

                        //debugPrint(allCourses[index].toString());
                        return Card(
                          margin: const EdgeInsets.all(16),
                          child: ListTile(
                              title: Text(documentSnapshot[
                                  'cname']), //allCourses[index].get('cname')),
                              subtitle: Text(documentSnapshot['cid']
                                  .toString()), //allCourses[index].get('cid').toString()),
                              leading: const Icon(
                                  Icons.account_balance_wallet_outlined),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentCourseHome(
                                            //constructor (passing course info)
                                            courseName:
                                                documentSnapshot['cname'],
                                            courseNumb: documentSnapshot['cid'],
                                            passedEmail: widget.passedEmail,
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
