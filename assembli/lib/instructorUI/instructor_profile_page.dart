import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:assembli/globals.dart' as globals;


//class holds basis for profile destination;
//will work similar to landing, linking other pages/states
//(linked from navigationBar destination in landing.dart)

class InstructorProfilePage extends StatelessWidget {
  const InstructorProfilePage({Key? key}) : super(key: key);

  // Log out button, redirects to login.dart
  //login also needs to close the firebase instance
      //might link it to the starter instance on main page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            
            //profile pic
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/profile_img.png')
                ),
              ),
            ),

            //identifier/name of running user
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: Color.fromARGB(255, 123, 123, 123),
                  fontSize: 18,
                  fontStyle: FontStyle.italic),
                child: Text('${globals.runningUser!.fname} ${globals.runningUser!.lname} '),
              ),
            ),

            //divider/padding
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              child: Divider(
                height: 50,
                thickness: 2,
                color: Color.fromARGB(255, 53, 53, 53),
              ),
            ),
            
            //logout button / redirect      ///need to reset glboals in onpressed feature////////////////////////
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 179, 194, 168))),
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: const Text('Log Out',style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}
