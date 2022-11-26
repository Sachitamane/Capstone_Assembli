import 'package:assembli/studentUI/student_announcements_page.dart';
import 'package:assembli/studentUI/student_courses_page.dart';
import 'package:assembli/studentUI/student_profile_page.dart';
import 'package:flutter/material.dart';

//this file is the basis for how our application looks, once logged in

class StudentLanding extends StatefulWidget {
  const StudentLanding({super.key});

  @override
  State<StudentLanding> createState() => _StudentLandingState();
}

//https://www.youtube.com/watch?v=qj7jcuU2Z10&t=183s persistent nav bar explained

//https://www.youtube.com/watch?v=P3x-JuA23SE
//proper routing with keeping the navigation bar there persistent

class _StudentLandingState extends State<StudentLanding> {

  int currentPage = 1;

  //list is used for the bottom navigation bar
  final pages = const [
    StudentAnnouncementsPage(),
    StudentCoursesPage(),
    StudentProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        title: const Text('Assembli'),
      ),
      body : IndexedStack(
        index: currentPage,
        children: pages,
        ),
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          indicatorColor: Color.fromARGB(255, 133, 151, 118),
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: currentPage,
          backgroundColor: const Color.fromARGB(255, 179, 194, 168),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (int index) {
            setState(() {
              currentPage = index;
            });
            debugPrint(pages[index].toString());
          },
          destinations: const [
            NavigationDestination(
                selectedIcon: Icon(Icons.article),
                icon: Icon(Icons.article_outlined),
                label: 'Announcements'),
            NavigationDestination(
                selectedIcon: Icon(Icons.fact_check),
                icon: Icon(Icons.fact_check_outlined),
                label: 'Courses'),
            NavigationDestination(
                selectedIcon: Icon(Icons.person),
                icon: Icon(Icons.person_outlined),
                label: 'Profile')
          ],
        ),
      ),
    );
  }
}
