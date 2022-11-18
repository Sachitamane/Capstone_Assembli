import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Takes user input and creates new document in "Request" collection
// upon pressing "submit" button, in pending status

class StudentCreateRequest extends StatefulWidget {
  const StudentCreateRequest({super.key});

  @override
  State<StudentCreateRequest> createState() => _StudentCreateRequest();
}

class _StudentCreateRequest extends State<StudentCreateRequest> {
  // Make controller for each field in the request document
  final cidController = TextEditingController();
  final dateController = TextEditingController();
  final reasonController = TextEditingController();
  final rnumController = TextEditingController();

  CollectionReference requests =
      FirebaseFirestore.instance.collection('Request');

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Get course id
            TextField(
              controller: cidController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'cid',
                  hintText: 'Enter course id'),
            ),

            // Get date of absence
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'date',
                  hintText: 'Enter date of absence'),
            ),

            // Get reason of absence
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'reason',
                  hintText: 'Enter reason of absence'),
            ),

            // Get student r number
            TextField(
              controller: rnumController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'rnum',
                  hintText: 'Enter your r number'),
            ),

            // Submit button
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 179, 194, 168))),
              onPressed: () {
                // Add new document to "Request" collection with user input as fields
                // In future, some may not be user input, such as rnum or cid
                FirebaseFirestore.instance.collection('Request').add({
                  'cid': cidController.text,
                  'date': dateController.text,
                  'reason': reasonController.text,
                  'rnum': rnumController.text,
                  'status': 'pending', // Will always be pending
                });
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            )
          ],
        ),
      );
}
