// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:assembli/user.dart';
import 'package:flutter/material.dart';
import 'package:assembli/instructorUI/instructor_course_home.dart';

class InstructorAnnouncement extends StatelessWidget {
  const InstructorAnnouncement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        title: Text(User.cname),
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(
                left: 15.0, right: 15.0, top: 75.0, bottom: 45.0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Announcement',
                  hintText: 'Enter your Announcement'),
            ),
          ),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    Color.fromARGB(255, 179, 194, 168))),
            onPressed: () {
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
            child: const Text(
              'Make Announcement',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ]),
      ),
    );
  }
}
