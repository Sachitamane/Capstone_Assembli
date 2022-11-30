import 'package:assembli/models/announcements_model.dart';
import 'package:flutter/material.dart';

//specifically tailors this page to announcements only from 
//the course selected (the class-caller)
class StudentCourseAnnouncements extends StatefulWidget {
  //const StudentCourseAnnouncements({super.key});
  final List<Announcement> announceList;

  const StudentCourseAnnouncements({
    Key? key,
    required this.announceList,

  }) : super(key: key);

  @override
  State<StudentCourseAnnouncements> createState() => _StudentCourseAnnouncementsState();
}

class _StudentCourseAnnouncementsState extends State<StudentCourseAnnouncements> {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 179, 194, 168),
      title: const Text('Assembli')
    ),
    body: Column(children: <Widget>[
      //turn to future builder maybe
      Expanded(
        child: ListView.builder(
          itemCount: widget.announceList.length,
    
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(16),
              child: ListTile(
                title: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  //date
                  const Text('Date: ', style: TextStyle(fontSize: 17)),
                  Text(widget.announceList[index].date,
                      style: const TextStyle(fontSize: 17)),//announcement message
                  const Text('Message: ', style: TextStyle(fontSize: 17)),
                  Text(widget.announceList[index].message,
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
                              widget.announces![index],
                              'approved');
                          setState(() {
                            widget.announces!.removeAt(index);
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
                              widget.announces![index],
                              'denied');
                          setState(() {
                            widget.announces!.removeAt(index);
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