import 'package:flutter/material.dart';
import 'package:assembli/instructor_course_home.dart';
import "package:assembli/user.dart";

class InstructorCoursesPage extends StatelessWidget {
  const InstructorCoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ListView.builder",
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        // home : new ListViewBuilder(),  NO Need To Use Unnecessary New Keyword
        home: ListViewBuilder());
  }
}

class ListViewBuilder extends StatelessWidget {
  ListViewBuilder({Key? key}) : super(key: key);
  List<String> courses = [];
  @override
  Widget build(BuildContext context) {
    courses = Courses.courseInfo;
    return Scaffold(
      body: ListView.builder(
          itemCount: Courses.courses.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(courses[index]),
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
}
