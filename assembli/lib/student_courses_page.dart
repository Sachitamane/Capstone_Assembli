import 'package:flutter/material.dart';
import 'package:assembli/student_course_home.dart';
import 'package:firebase_core/firebase_core.dart';


//changing pushAndRemoveUntil into push only
//change to stateful, 

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
}

