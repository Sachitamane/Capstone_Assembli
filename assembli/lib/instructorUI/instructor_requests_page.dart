import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Completed: Displays all pending requests in Request collection
//            Approve/Deny buttons for each

// Not completed: Rnum needs to link to specific user
//                Show only requests from students the professor
//                actually teaches
//                Make approve deny buttons functional (update db)

class InstructorRequestsPage extends StatefulWidget {
  const InstructorRequestsPage({super.key});

  @override
  State<InstructorRequestsPage> createState() => _InstructorRequestsPageState();
}

class _InstructorRequestsPageState extends State<InstructorRequestsPage> {
  final controller = TextEditingController();
  // Only show requests with status == "pending"
  // contained in Request collection
  //CollectionReference requests =
  //    FirebaseFirestore.instance.collection('Request');
  Query<Map<String, dynamic>> requestCollection = FirebaseFirestore.instance
      .collection('Request')
      .where("status", isEqualTo: "pending");

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
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              // Show class, cid, and rnum,
                              // seperated by SizedBoxes to look nice
                              title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text('Class: ',
                                        style: TextStyle(fontSize: 17)),
                                    Text(
                                      documentSnapshot['cid'],
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                      height: 50,
                                    ),
                                    const Text('Rnum: ',
                                        style: TextStyle(fontSize: 17)),
                                    Text(documentSnapshot['rnum'],
                                        style: const TextStyle(fontSize: 17)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text('Reason: ',
                                        style: TextStyle(fontSize: 17)),
                                    Text(documentSnapshot['reason'],
                                        style: const TextStyle(fontSize: 17)),
                                  ]),
                              // Section for approve and deny
                              subtitle: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    // Approve button
                                    SizedBox(
                                      width: 105,
                                      height: 30,
                                      child: ElevatedButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    Color.fromARGB(
                                                        255, 179, 194, 168))),
                                        onPressed:
                                            () {}, // Will need to add functionality to update to db
                                        child: const Text(
                                          'Approve',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    // Deny button
                                    const SizedBox(
                                      width: 10,
                                      height: 37,
                                    ),
                                    SizedBox(
                                        height: 30,
                                        width: 85,
                                        child: ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                          Color>(
                                                      Color.fromARGB(
                                                          255, 179, 194, 168))),
                                          onPressed:
                                              () {}, // Will need to add functionality to update to db
                                          child: const Text(
                                            'Deny',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                        ))
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
