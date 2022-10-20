import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: const Text('Assembli'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Button pressed');
        },
        child: const Icon(Icons.grade_outlined),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.article_outlined), label: 'Announcements'),
          NavigationDestination(
              icon: Icon(Icons.fact_check), label: 'Courses'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile')
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
          debugPrint("dest select");
        },
        selectedIndex: currentPage,
      ),
    );
  }
}