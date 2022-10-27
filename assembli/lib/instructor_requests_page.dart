import 'package:flutter/material.dart';

//class holds basis for announcements destination;
//will work similar to landing, linking other pages/states
//(linked from navigationBar destination in landing.dart)

class InstructorRequestsPage extends StatelessWidget {
  const InstructorRequestsPage({Key? key}) : super(key: key);

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
          trailing: Text("Pending"),
          title: Text("John Doe"),
        ),
        ListTile(
          leading: Text("(11/22)"),
          trailing: Text("Pending"),
          title: Text("Kimberly Fisher"),
        ),
        ListTile(
          leading: Text("(11/20)"),
          trailing: Text("Pending"),
          title: Text("Alyssa Nooney"),
        ),
        ListTile(
          leading: Text("(10/31)"),
          trailing: Text("Pending"),
          title: Text("Eric Wright"),
        ),
        ListTile(
          leading: Text("(09/10)"),
          trailing: Text("Pending"),
          title: Text("Erica Fuller"),
        ),
        ListTile(
          leading: Text("(08/18)"),
          trailing: Text("Pending"),
          title: Text("George Brown"),
        ),
      ],
    );
  }
}
