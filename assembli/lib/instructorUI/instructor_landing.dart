import 'package:assembli/instructorUI/instructor_requests_page.dart';
import 'package:assembli/instructorUI/instructor_courses_page.dart';
import 'package:assembli/instructorUI/instructor_profile_page.dart';
import 'package:flutter/material.dart';

//this file is the basis for how our application looks, once logged in

class InstructorLanding extends StatefulWidget {
  const InstructorLanding({super.key});

  @override
  State<InstructorLanding> createState() => _InstructorLandingState();
}

class _InstructorLandingState extends State<InstructorLanding> {
  //im a little fuzzy on how this var is set, but current page is used in
  //setting the index value in selectedIndex: (see line 41 and line 47) aka setState()
  int currentPage = 1;

  //list is used for the bottom navigation bar
  List pages = const [
    InstructorRequestsPage(),
    InstructorCoursesPage(),
    InstructorProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        title: const Text('Assembli'),
      ),
      body: pages[currentPage],
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
            debugPrint("dest select");
          },
          destinations: const [
            NavigationDestination(
                selectedIcon: Icon(Icons.article),
                icon: Icon(Icons.article_outlined),
                label: 'Requests'),
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
