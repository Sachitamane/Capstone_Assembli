import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Completed:     Show requests from db
// Not Completed: Need to only show requests from
//                that specific student
//                Place for student to make new request based
//                upon absence (will need attendance record)

class StudentRequestPage extends StatefulWidget {
  const StudentRequestPage({super.key});

  @override
  State<StudentRequestPage> createState() => _StudentRequestPageState();
}

class _StudentRequestPageState extends State<StudentRequestPage> {
  final controller = TextEditingController();
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('Request');

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(children: <Widget>[
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
                        return Card(
                          margin: const EdgeInsets.all(16),
                          child: ListTile(
                            // Put all request information here
                            title: Text(documentSnapshot['status']),
                            // Have approve/deny button for each
                            subtitle: Text(documentSnapshot['reason']),
                          ),
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
