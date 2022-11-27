import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  State<StudentProfilePage> createState() => _StudentProfilePage();
}

class _StudentProfilePage extends State<StudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: SizedBox(
                  //used to be Container
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/profile_img.png')),
            ),
          ),
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
            child: DefaultTextStyle(
              style: const TextStyle(
                  color: Color.fromARGB(255, 123, 123, 123),
                  fontSize: 18,
                  fontStyle: FontStyle.italic),
              child: Text('student name'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Divider(
              height: 50,
              thickness: 2,
              color: Color.fromARGB(255, 53, 53, 53),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(255, 179, 194, 168))),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const Login();
                      },
                    ),
                    (route) => false,
                  );
                },
                child: const Text('Log Out',
                    style: TextStyle(color: Colors.white, fontSize: 25)),
              ))
        ])));
  }
}

// class StudentProfilePage extends StatelessWidget {
//   const StudentProfilePage({Key? key}) : super(key: key);

//   // Log out button, redirects to login.dart
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: ElevatedButton(
//       style: const ButtonStyle(
//           backgroundColor: MaterialStatePropertyAll<Color>(
//               Color.fromARGB(255, 179, 194, 168))),
//       onPressed: () {
//           Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (BuildContext context) {
//                           return const Login();
//                         },
//                       ),
//                       (route) => false,
//                     );
//       },
//       child: const Text('Log Out',
//           style: TextStyle(color: Colors.white, fontSize: 25)),
//     ));
//   }
// }
