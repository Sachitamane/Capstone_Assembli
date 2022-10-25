import 'package:flutter/material.dart';

class StudentAnnouncementsPage extends StatefulWidget {
  const StudentAnnouncementsPage({super.key});  

  @override
  State<StudentAnnouncementsPage> createState() => _StudentAnnouncementsPage();

}

class _StudentAnnouncementsPage extends State<StudentAnnouncementsPage>{
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Announcements Page"),
    );
    //block is for testing state changes
    /* 
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
          child: Text(
            '$count',
            style: Theme.of(context).textTheme.headline2,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: const Text('Increment'),
          )
      ],
    );*/
  }
}

//ref to change (moved from stateless to stateful)//////////////////////////////////

/*
class StudentAnnouncementsPage extends StatelessWidget {
  const StudentAnnouncementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Announcements Page"),
    );
  }
}
*/