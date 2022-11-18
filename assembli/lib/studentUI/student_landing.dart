import 'package:assembli/studentUI/student_announcements_page.dart';
import 'package:assembli/studentUI/student_courses_page.dart';
import 'package:assembli/studentUI/student_profile_page.dart';
import 'package:flutter/material.dart';

//this file is the basis for how our application looks, once logged in

class StudentLanding extends StatefulWidget {
  final String passedEmail;

  const StudentLanding({Key? key, required this.passedEmail}) : super(key: key);

  @override
  State<StudentLanding> createState() => _StudentLandingState();
}

class _StudentLandingState extends State<StudentLanding> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    //list is used for the bottom navigation bar
    final pages = [
      StudentAnnouncementsPage(),
      StudentCoursesPage(
        passedEmail: widget.passedEmail,
      ),
      StudentProfilePage()
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        title: const Text('Assembli'),
      ),
      body: IndexedStack(
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
