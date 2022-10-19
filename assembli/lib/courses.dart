import 'package:assembli/home_page.dart';
import 'package:flutter/material.dart';

class Assembli extends StatelessWidget {
  const Assembli({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentPage = 0; // variable creation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assembli'),
      ),
      body: const Homepage(),
      floatingActionButton: FloatingActionButton(
        //empy function next to onPressed argument
        onPressed: () {
          debugPrint('Button pressed');
        },
        child: const Icon(Icons.grade_outlined),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.article_outlined), label: 'Courses'),
          NavigationDestination(
              icon: Icon(Icons.fact_check), label: 'Attendance'),
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
