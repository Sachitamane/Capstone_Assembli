import 'package:assembli/models/attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:assembli/globals.dart' as globals;


class InstructorCourseAttendance extends StatefulWidget {
  //const InstructorCourseAttendance({super.key});

  final List<Attendance> attenList;

  const InstructorCourseAttendance({
    Key? key,
    required this.attenList,

  }) : super(key: key);

  @override
  State<InstructorCourseAttendance> createState() => _InstructorCourseAttendanceState();
}

class _InstructorCourseAttendanceState extends State<InstructorCourseAttendance> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 179, 194, 168),
    ),
    body: Column(
      children: <Widget>[
        //took out the search bar
        //list of courses pertaining to current appuser
        Expanded(
          child: ListView.builder(
            itemCount: widget.attenList.length,
            itemBuilder:(context, index){
              bool present = widget.attenList[index].present;
              return ListTile(
//              return Card(
//                margin:  const EdgeInsets.all(16),
//                child: ListTile(
                  title: Text(widget.attenList[index].date.toString()),
                  tileColor: present? Colors.green : Colors.red,
                  /*onTap: () {
                    //optional sending a request for a past instance of attendance to be modified
                  }*/
//                ),
              );
            }
          )
        )
      ]
    ),
  );

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 179, 194, 168),
      title: const Text('Course attendance'),

      ),
      body : const Center(
        child:  Text('attendence page'))

    );
  }
  */
}