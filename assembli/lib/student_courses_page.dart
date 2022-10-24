import 'package:flutter/material.dart';
import 'package:assembli/student_course_home.dart';

//class holds basis for courses destination;
//will work similar to landing, linking other pages/states
//(linked from navigationBar destination in landing.dart)

class StudentCoursesPage extends StatelessWidget {
  const StudentCoursesPage({Key? key}) : super(key: key);

  //@override
  //Widget build(BuildContext context) {
  //return const Center(
  //  child: Text("Courses Page"),
  //);
  //}

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

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

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
                      return const StudentCourseHome();
                    },
                  ),
                  (route) => false,
                );
              },
            );
          }),
    );
  }
}
