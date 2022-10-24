import 'package:flutter/material.dart';

//class holds basis for courses destination;
//will work similar to landing, linking other pages/states
//(linked from navigationBar destination in landing.dart)

class StudentCoursesPage extends StatelessWidget {
  const StudentCoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Student Courses Page"),
    );
  }
}
