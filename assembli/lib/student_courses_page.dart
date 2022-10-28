
import 'package:flutter/material.dart';
//import 'package:assembli/student_course_home.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//changing pushAndRemoveUntil into push only
//change to stateful, then figure out how to read from DB
//https://www.youtube.com/watch?v=ZHdg2kfKmjI

class StudentCoursesPage extends StatefulWidget {
  const StudentCoursesPage({super.key});

  @override
  State<StudentCoursesPage> createState() => _StudentCoursesPageState();
}
class _StudentCoursesPageState extends State<StudentCoursesPage> {
  final controller = TextEditingController();
  final CollectionReference courseCollection = FirebaseFirestore.instance.collection('Course');

  @override
  Widget build(BuildContext context) => Scaffold(
      /*appBar: AppBar(
        title: const Text('draft'),
      ),*/
      body: Column(
      children: <Widget>[
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
          /////////////////////START HERE LATER
         // onChanged: searchCourse, 
        ),
      ),

      //may work with better connection or different wifi, try again later
      //ref video for CRUD (Read) db operations https://www.youtube.com/watch?v=n1PM9XcYD5s&list=PL4tcFRTiQTj2BeFQ0e97C0ZQAi8l-HOM4&index=4
      Expanded(
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
                      subtitle: const Text('dubbb'),
                    ),
                    );
                },
              );
            }
            return const Center(child: CircularProgressIndicator(),);
          }
        ),
      )
      ]
    ),
  );
  //ref video https://www.youtube.com/watch?v=ZHdg2kfKmjI&list=PL4tcFRTiQTj2BeFQ0e97C0ZQAi8l-HOM4&index=9&t=1s
 /* void searchCourse(String query){
    final suggestions = 
  }*/
////////////////////////////////////WHAT'S TO BE DISPLAYED IN LISTVIEW
  /*Widget buildUser(Course course) => ListTile(
    leading: CircleAvatar(child: Text(/*'${course.cname}'*/ course.cname)),
  );


  Stream<List<Course>> readCourses() => FirebaseFirestore.instance
      .collection('Course')
      .snapshots()  /*gets all documents from firebase collection*/
      .map((snapshot) =>
          snapshot.docs.map((doc) => Course.fromJson(doc.data())).toList()
      );*/
}

/*
class StudentCoursesPage extends StatelessWidget {
  const StudentCoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ListView.builder",
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        // home : new ListViewBuilder(),  NO Need To Use Unnecessary New Keyword
        home: const ListViewBuilder());
  }
}

class ListViewBuilder extends StatelessWidget{
  const ListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text("CS - 4366 Senior Capstone Project"),
                onTap: () {
                  // Navigator.pushAndRemoveUntil(
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const StudentCourseHome();
                      },
                    ),
                    //(route) => false,
                  );
                },
              ),
            );
          }
          ),
    );

    
  }
}
*/
/////////////////////////////////////////////////////////////////////////////////////////////
class Course{
  final int rnum;         //teacher rnum
  final int cid;          //courseid number "4366, 3354, ..."
  final int sect;         //section for course
  final String cname;     //course name/identifier
  final int crn;          //crn

  Course({
    required this.cid,
    this.cname = '',
    required this.crn,
    required this.rnum,
    required this.sect,
  });

  Map<String, dynamic> toJson() => {
    'cid': cid,
    'cname': cname,
    'crn': crn,
    'rnum': rnum,
    'sect': sect,
  };

  static Course fromJson(Map<String, dynamic> json) => Course(
    cid: json['cid'],
    cname: json['cname'],
    crn: json['crn'],
    rnum: json['rnum'],
    sect: json['sect'],
  );
}

