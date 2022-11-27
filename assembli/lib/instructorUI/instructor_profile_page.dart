import 'package:flutter/material.dart';
import 'package:assembli/login.dart';

//class holds basis for profile destination;
//will work similar to landing, linking other pages/states
//(linked from navigationBar destination in landing.dart)

class InstructorProfilePage extends StatefulWidget {
  const InstructorProfilePage({Key? key}) : super(key: key);

  @override
  State<InstructorProfilePage> createState() => _InstructorProfilePage();
}

class _InstructorProfilePage extends State<InstructorProfilePage> {
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
              child: Text('instructor name'),
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
  



  

//   Log out button, redirects to login.dart
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
//           },
//       child: const Text('Log Out',
//           style: TextStyle(color: Colors.white, fontSize: 25)),
//     ));
//   }
// }
