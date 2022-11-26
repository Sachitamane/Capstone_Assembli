import 'package:flutter/material.dart';
import 'package:assembli/instructorUI/instructor_course_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InstructorAnnouncement extends StatelessWidget {
  InstructorAnnouncement({Key? key}) : super(key: key);
  CollectionReference announce =
      FirebaseFirestore.instance.collection('Announcement');
  @override
  Widget build(BuildContext context) {
    final announcementMessage = TextEditingController();
    String announcement = "";
    return Scaffold(
      body: Center(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(
                left: 15.0, right: 15.0, top: 75.0, bottom: 45.0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: announcementMessage,
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
              announcement = announcementMessage.text;
              announce.add({
                'cid': "4366",
                "cname": "Capstone",
                "crn": 32061,
                "message": announcement
              });
              Navigator.pop(context);
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