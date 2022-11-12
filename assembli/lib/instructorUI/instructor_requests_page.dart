import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Completed: Get app to display every status that's in db
//            Have Approve and Deny button for each
// Not completed: Student info does not show, every request
//                is showing, should only show pending
//                Show only requests from students the professor
//                actually teaches

class InstructorRequestsPage extends StatefulWidget {
  const InstructorRequestsPage({super.key});

  @override
  State<InstructorRequestsPage> createState() => _InstructorRequestsPageState();
}

class _InstructorRequestsPageState extends State<InstructorRequestsPage> {
  final controller = TextEditingController();
  CollectionReference requestCollection =
      FirebaseFirestore.instance.collection('Request');

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: requestCollection.snapshots(),
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
                              title: Text(
                                documentSnapshot['status'],
                                style: TextStyle(fontSize: 20),
                              ),
                              // Have approve/deny button for each
                              //subtitle: const Text('Approve | Deny'),
                              subtitle: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  Color.fromARGB(
                                                      255, 179, 194, 168))),
                                      onPressed: () {},
                                      // Update database to "Approved"
                                      child: const Text(
                                        'Approve',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  Color.fromARGB(
                                                      255, 179, 194, 168))),
                                      onPressed: () {},
                                      // Update database to "Denied"
                                      child: const Text(
                                        'Deny',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      ),
                                    )
                                  ])),
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
