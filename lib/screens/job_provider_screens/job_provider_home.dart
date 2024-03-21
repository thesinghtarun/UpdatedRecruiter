import 'package:flutter/material.dart';
import 'package:recruiter/screens/job_provider_screens/add_jobs.dart';
import 'package:recruiter/screens/job_provider_screens/chat.dart';
import 'package:recruiter/screens/job_provider_screens/job_provider_homepage.dart';
import 'package:recruiter/screens/job_provider_screens/job_provider_profile.dart';

class JobProviderHomeScreen extends StatefulWidget {
  const JobProviderHomeScreen({super.key});

  @override
  State<JobProviderHomeScreen> createState() => _JobProviderHomeScreenState();
}

class _JobProviderHomeScreenState extends State<JobProviderHomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final _bottomNavigationBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.add_box_rounded,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Add",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.message,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Chat",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.person_pin_rounded,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Profile",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          children: const [
            HomePage(),
            Add(),
            Chat(),
            Profile(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 85, 143, 151),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,

          currentIndex: _currentIndex,
          items: _bottomNavigationBarItem,
          onTap: (value) {
            _pageController.animateToPage(value,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
          // type: BottomNavigationBarType.fixed,
        ));
  }
}
