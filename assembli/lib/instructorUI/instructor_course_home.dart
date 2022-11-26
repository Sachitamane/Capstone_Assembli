import 'package:flutter/material.dart';
import 'package:assembli/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InstructorCourseHome extends StatefulWidget {
  const InstructorCourseHome(
      {Key? key, required courseNumb, required courseName})
      : super(key: key);

  @override
  State<InstructorCourseHome> createState() => _InstructorCourseHome();
}

class _InstructorCourseHome extends State<InstructorCourseHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 35),
              const Padding(
                padding:
                    EdgeInsets.only(top: 30, bottom: 10, left: 5, right: 10),
                child: DefaultTextStyle(
                  style: TextStyle(
                      color: Color.fromARGB(255, 6, 6, 6),
                      fontSize: 23,
                      fontStyle: FontStyle.italic),
                  child: Text('CS: class'),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                child: Divider(
                  height: 50,
                  thickness: 5,
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
                    child: const Text('Open Attendance',
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
                    child: const Text('Attendance Score',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  ),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                child: Divider(
                  height: 50,
                  thickness: 5,
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
                    child: const Text('Make Announcement',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  ),
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
                    child: const Text('View Analytics',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
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






//   @override
//   Widget build(BuildContext context) {
//     // ignore: prefer_const_constructors
//     return Center(
//       child: Column(children: [
        // ElevatedButton(
        //   style: const ButtonStyle(
        //       backgroundColor: MaterialStatePropertyAll<Color>(
        //           Color.fromARGB(255, 179, 194, 168))),
        //   onPressed: () {
        //     Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(
        //         builder: (BuildContext context) {
        //           return const LocationSetter();
        //         },
        //       ),
        //       (route) => false,
        //     );
        //   },
        //   child: const Text('Open Attendance',
        //       style: TextStyle(color: Colors.white, fontSize: 25)),
        // ),
//         ElevatedButton(
//           style: const ButtonStyle(
//               backgroundColor: MaterialStatePropertyAll<Color>(
//                   Color.fromARGB(255, 179, 194, 168))),
//           onPressed: () {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (BuildContext context) {
//                   return const LocationSetter();
//                 },
//               ),
//               (route) => false,
//             );
//           },
//           child: const Text('Make Announcement',
//               style: TextStyle(color: Colors.white, fontSize: 25)),
//         )
//       ]),
//     );
//   }
// }
