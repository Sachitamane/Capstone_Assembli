import 'package:flutter/material.dart';
import 'package:assembli/services/dbservice.dart';
import 'package:assembli/globals.dart' as globals;


class StudentAnnouncementsPage extends StatefulWidget {
  const StudentAnnouncementsPage({super.key});  

  @override
  State<StudentAnnouncementsPage> createState() => _StudentAnnouncementsPage();

}

class _StudentAnnouncementsPage extends State<StudentAnnouncementsPage>{
  
  final Control ctrl = Control(
                  authUser: globals.authUser,
                  user: globals.runningUser
                );
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(children: <Widget>[
      //turn to future builder maybe
      Expanded(
        child: ListView.builder(
          itemCount: globals.runningUser!.announcements!
                    .length,
              //.where((request) => request.status.compareTo('pending') == 0)
              //.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(16),
              child: ListTile(
                title: Wrap(/*mainAxisSize: MainAxisSize.min, */children: <Widget>[
                  // Display cid
                  const Text('Class: ', style: TextStyle(fontSize: 17)),
                  Text(globals.runningUser!.announcements![index].crn.toString(),
                      style: const TextStyle(fontSize: 17)),
                  const SizedBox(width: 10, height: 50),
                  const SizedBox(width: 10),
                  //figure out how to fix overflowing text//////////////////////////////////////////////
                  // Display reason
                  const Text('Message: ', style: TextStyle(fontSize: 17)),
                  Text(globals.runningUser!.announcements![index].message,
                      style: const TextStyle(fontSize: 17)),
                ]),
                // subtitle: row with approve/deny buttons
                /*subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Approve button
                    SizedBox(
                      width: 105,
                      height: 30,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromARGB(255, 179, 194, 168))),
                        onPressed: () {
                          // Update status in db for specific document
                          ctrl.updateRequest(
                              globals.runningUser!.announces![index],
                              'approved');
                          setState(() {
                            globals.runningUser!.announces!.removeAt(index);
                          });
                        },
                        child: const Text(
                          'Approve',
                          style: TextStyle(color: Colors.white, fontSize: 17),
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
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromARGB(255, 179, 194, 168))),
                        onPressed: () {
                          // Update status in db for specific document
                          ctrl.updateRequest(
                              globals.runningUser!.announces![index],
                              'denied');
                          setState(() {
                            globals.runningUser!.announces!.removeAt(index);
                          });
                        },
                        child: const Text(
                          'Deny',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
                */
              ),
            );
          },
        ),
      )
    ])
  );
}

