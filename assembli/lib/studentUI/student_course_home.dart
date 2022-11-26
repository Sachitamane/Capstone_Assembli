import 'package:flutter/material.dart';
import 'package:assembli/location.dart';

class StudentCourseHome extends StatefulWidget {
  //const StudentCourseHome({Key? key, required courseNumb, required courseName})
  //  : super(key: key);

  final String courseName;
  final int courseNumb;

  const StudentCourseHome({
    Key? key,
    required this.courseName,
    required this.courseNumb,
  }) : super(key: key);

  @override
  State<StudentCourseHome> createState() => _StudentCourseHome();
}

class _StudentCourseHome extends State<StudentCourseHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        title: Text('Assembli'),
      ),
      resizeToAvoidBottomInset: false,
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 5, right: 10),
                child: DefaultTextStyle(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 123, 123, 123),
                      fontSize: 20,
                      fontStyle: FontStyle.italic),
                  child: Text(widget.courseName),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                child: Divider(
                  height: 20,
                  thickness: 2,
                  color: Color.fromARGB(255, 243, 113, 113),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 20, left: 10, right: 10),
                child: SizedBox(
                  width: 400,
                  height: 45,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 179, 194, 168))),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const LocationSetter();
                          },
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text('Log my Attendance',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 20, left: 10, right: 10),
                child: SizedBox(
                  width: 400,
                  height: 60,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 255, 255, 255))),
                    onPressed: () {
                      ///////add on pressed function here
                    },
                    child: const Text('Attendance Score',
                        style: TextStyle(
                            color: Color.fromARGB(255, 91, 90, 90),
                            fontSize: 20)),
                  ),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                child: Divider(
                  height: 20,
                  thickness: 2,
                  color: Color.fromARGB(255, 243, 113, 113),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                child: SizedBox(
                  width: 400,
                  height: 45,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 179, 194, 168))),
                    onPressed: () {
                      /////add on pressed function here
                    },
                    child: const Text('Request Excused Absence',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}







// class StudentCourseHome extends StatelessWidget {
//   const StudentCourseHome(
//       {Key? key, required String courseName, required int courseNumb})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // ignore: prefer_const_constructors
//     return Center(
//         child: ElevatedButton(
//       style: const ButtonStyle(
//           backgroundColor: MaterialStatePropertyAll<Color>(
//               Color.fromARGB(255, 179, 194, 168))),
//       onPressed: () {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (BuildContext context) {
//               return const LocationFinder();
//             },
//           ),
//           (route) => false,
//         );
//       },
//       child: const Text('Log my Attendance',
//           style: TextStyle(color: Colors.white, fontSize: 25)),
//     ));
//   }
// }
