import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assembli/user.dart';

class StudentAnnouncementsPage extends StatefulWidget {
  const StudentAnnouncementsPage({super.key});

  @override
  State<StudentAnnouncementsPage> createState() => _StudentAnnouncementsPage();
}

class _StudentAnnouncementsPage extends State<StudentAnnouncementsPage> {
  final CollectionReference announcementCollection =
      FirebaseFirestore.instance.collection('Announcement');
  @override
  Widget build(BuildContext context) {
    User.courses = ["32061", "34422", "39471", "34421"];
    return Expanded(
      child: StreamBuilder(
          stream: announcementCollection.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  if (User.courses
                      .contains(documentSnapshot['crn'].toString())) {
                    return Card(
                      margin: const EdgeInsets.all(16),
                      child: ListTile(
                        title: Text(
                            "${documentSnapshot['cid']} ${documentSnapshot['cname']}"),
                        subtitle: Text(documentSnapshot['message']),
                      ),
                    );
                  } else {
                    return Center();
                  }
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
    //   children: const <Widget>[
    //     ListTile(
    //       leading: Text("(12/04)"),
    //       trailing: Text("Class Cancelled"),
    //       title: Text("CS-4366"),
    //     ),
    //     ListTile(
    //       leading: Text("(11/22)"),
    //       trailing: Text("Class Cancelled"),
    //       title: Text("CS-4352"),
    //     ),
    //     ListTile(
    //       leading: Text("(11/20)"),
    //       trailing: Text("Class Cancelled"),
    //       title: Text("CS-4354"),
    //     ),
    //     ListTile(
    //       leading: Text("(10/31)"),
    //       trailing: Text("Class Cancelled"),
    //       title: Text("CS-4366"),
    //     ),
    //     ListTile(
    //       leading: Text("(09/10)"),
    //       trailing: Text("Class Cancelled"),
    //       title: Text("BA-3305"),
    //     ),
    //     ListTile(
    //       leading: Text("(08/18)"),
    //       trailing: Text("Class Cancelled"),
    //       title: Text("CS-4354"),
    //     ),
    //   ],
    // );
  }
}


/*
class StudentAnnouncementsPage extends StatelessWidget {
  const StudentAnnouncementsPage({Key? key}) : super(key: key);

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

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        ListTile(
          leading: Text("(12/04)"),
          trailing: Text("Class Cancelled"),
          title: Text("CS-4366"),
        ),
        ListTile(
          leading: Text("(11/22)"),
          trailing: Text("Class Cancelled"),
          title: Text("CS-4352"),
        ),
        ListTile(
          leading: Text("(11/20)"),
          trailing: Text("Class Cancelled"),
          title: Text("CS-4354"),
        ),
        ListTile(
          leading: Text("(10/31)"),
          trailing: Text("Class Cancelled"),
          title: Text("CS-4366"),
        ),
        ListTile(
          leading: Text("(09/10)"),
          trailing: Text("Class Cancelled"),
          title: Text("BA-3305"),
        ),
        ListTile(
          leading: Text("(08/18)"),
          trailing: Text("Class Cancelled"),
          title: Text("CS-4354"),
        ),
      ],
    );
  }
}
*/