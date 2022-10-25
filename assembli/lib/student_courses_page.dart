import 'package:flutter/material.dart';
import 'package:assembli/student_course_home.dart';
//changing pushAndRemoveUntil into push only

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
          }),
    );
  }
}
