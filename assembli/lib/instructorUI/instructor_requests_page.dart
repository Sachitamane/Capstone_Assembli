import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assembli/services/dbservice.dart';
import 'package:assembli/globals.dart' as globals;


// Displays all pending requests in "Request" collection
// Can be approved or denied, db will update accordingly

class InstructorRequestsPage extends StatefulWidget {
  const InstructorRequestsPage({super.key});

  @override
  State<InstructorRequestsPage> createState() => _InstructorRequestsPageState();
}

class _InstructorRequestsPageState extends State<InstructorRequestsPage> {

  final Control ctrl = Control(
                  authUser: globals.authUser,
                  user: globals.runningUser
                );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[

            //turn to future builder later
            //https://www.youtube.com/watch?v=IXBLP1bMeBE
            Expanded(
              child: ListView.builder(
                itemCount: globals.runningUser!.requests!
                          .where((request) => request.status.compareTo('pending') == 0).length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(16),
                    child: ListTile(
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Display cid
                          const Text('Class: ', style: TextStyle(fontSize: 17)),
                                Text(globals.runningUser!.requests![index].crn.toString(), style: const TextStyle(fontSize: 17)),
                          const SizedBox(width: 10, height: 50),
                          // Display rnum
                          const Text('Student: ', style: TextStyle(fontSize: 17)),
                                Text(globals.runningUser!.requests![index].rnum.toString(), style: const TextStyle(fontSize: 17)),
                          const SizedBox(width: 10),
      //figure out how to fix overflowing text//////////////////////////////////////////////
                          // Display reason
                          const Text('Reason: ', style: TextStyle(fontSize: 17)),
                                Text(globals.runningUser!.requests![index].reason, style: const TextStyle(fontSize: 17)),
                        ]
                      ),
                      // subtitle: row with approve/deny buttons
                      subtitle: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          // Approve button
                          SizedBox(
                            width: 105,
                            height: 30,
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:  MaterialStatePropertyAll<Color>(
                                  Color.fromARGB(255, 179, 194, 168)
                                )
                              ),
                              onPressed: () {
                                // Update status in db for specific document
                                ctrl.updateRequest(globals.runningUser!.requests![index], 'approved');
                                setState(() { 
                                  globals.runningUser!.requests!.removeAt(index);
                                  }
                                );

                              },
                              child: const Text('Approve', style: TextStyle(
                                color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10, height: 37),
                          
                          // Deny button
                          SizedBox(
                            height: 30,
                            width: 85,
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:  MaterialStatePropertyAll<Color>(
                                  Color.fromARGB(255, 179, 194, 168)
                                )
                              ),
                              onPressed: () {
                                // Update status in db for specific document
                                ctrl.updateRequest(globals.runningUser!.requests![index], 'denied');
                                setState(() { 
                                  globals.runningUser!.requests!.removeAt(index);
                                  }
                                );
                              },
                              child: const Text('Deny', style: TextStyle(
                                color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )   
          ]
        )
      );
      
      //old UI
  /*final controller = TextEditingController();
  Query<Map<String, dynamic>> requestCollection = FirebaseFirestore.instance
      .collection('Request')
      .where("status", isEqualTo: "pending"); // Only get pending requests

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: requestCollection.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    // Create ListView with pending requests
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            // title: row showing student request information
                            title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  // Display cid
                                  const Text('Class: ',
                                      style: TextStyle(fontSize: 17)),
                                  Text(
                                    documentSnapshot['cid'],
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  const SizedBox(width: 10, height: 50),

                                  // Display rnum
                                  const Text('Rnum: ',
                                      style: TextStyle(fontSize: 17)),
                                  Text(documentSnapshot['rnum'],
                                      style: const TextStyle(fontSize: 17)),
                                  const SizedBox(width: 10),

                                  // Display reason
                                  const Text('Reason: ',
                                      style: TextStyle(fontSize: 17)),
                                  Text(documentSnapshot['reason'],
                                      style: const TextStyle(fontSize: 17)),
                                ]),

                            // subtitle: row with approve/deny buttons
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
                                    onPressed: () {
                                      // Update status in db for specific document
                                      documentSnapshot.reference
                                          .update({'status': 'approved'});
                                    },
                                    child: const Text(
                                      'Approve',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10, height: 37),

                                // Deny button
                                SizedBox(
                                  height: 30,
                                  width: 85,
                                  child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                Color.fromARGB(
                                                    255, 179, 194, 168))),
                                    onPressed: () {
                                      // Update status in db for specific document
                                      documentSnapshot.reference
                                          .update({'status': 'denied'});
                                    },
                                    child: const Text(
                                      'Deny',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      );
      */
}
