// import 'package:flutter/material.dart';
// //import 'package:assembli/student_course_home.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// //missing connection to student_course_home.dart page upon pressing links

// class StudentCoursesPage extends StatefulWidget {
//   const StudentCoursesPage({super.key});

//   @override
//   State<StudentCoursesPage> createState() => _StudentCoursesPageState();
// }

// class _StudentCoursesPageState extends State<StudentCoursesPage> {
//   final controller = TextEditingController();
//   final CollectionReference courseCollection =
//       FirebaseFirestore.instance.collection('Course');

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: Column(children: <Widget>[
//           //search bar : //https://www.youtube.com/watch?v=ZHdg2kfKmjI
//           Container(
//             margin: const EdgeInsets.all(16),
//             child: TextField(
//               controller: controller,
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.search),
//                 hintText: 'Search Courses',
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(
//                         color: Color.fromARGB(255, 179, 194, 168))),
//               ),
//               /////////////////////START HERE LATER
//               // onChanged: searchCourse,
//             ),
//           ),

//           //may work with better connection or different wifi, try again later
//           //ref video for CRUD (Read) db operations https://www.youtube.com/watch?v=n1PM9XcYD5s&list=PL4tcFRTiQTj2BeFQ0e97C0ZQAi8l-HOM4&index=4
//           Expanded(
//             child: StreamBuilder(
//                 stream: courseCollection.snapshots(),
//                 builder:
//                     (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//                   if (streamSnapshot.hasData) {
//                     return ListView.builder(
//                       itemCount: streamSnapshot.data!.docs.length,
//                       itemBuilder: (context, index) {
//                         final DocumentSnapshot documentSnapshot =
//                             streamSnapshot.data!.docs[index];
//                         return Card(
//                           margin: const EdgeInsets.all(16),
//                           child: ListTile(
//                             title: Text(documentSnapshot['cname']),
//                             subtitle: const Text('dubbb'),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }),
//           )
//         ]),
//       );
// }

import 'package:flutter/material.dart';
import 'package:assembli/studentUI/student_course_home.dart';

class StudentCoursesPage extends StatelessWidget {
  const StudentCoursesPage({Key? key}) : super(key: key);

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
    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("CS - 4366 Senior Capstone Project"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const StudentCourseHome();
                    },
                  ),
                  (route) => false,
                );
              },
            );
          }),
    );
  }
}
