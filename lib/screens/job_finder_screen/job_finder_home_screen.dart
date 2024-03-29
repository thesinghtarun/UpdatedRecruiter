import 'package:flutter/material.dart';
import 'package:recruiter/screens/job_finder_screen/applied_jobs.dart';
import 'package:recruiter/screens/job_finder_screen/favourite.dart';
import 'package:recruiter/screens/job_finder_screen/job_finder_homepage.dart';
import 'package:recruiter/screens/job_finder_screen/job_finder_profile.dart';
import 'package:recruiter/screens/job_finder_screen/search.dart';

class JobFinderHomeScreen extends StatefulWidget {
  const JobFinderHomeScreen({super.key});

  @override
  State<JobFinderHomeScreen> createState() => _JobFinderHomeScreenState();
}

class _JobFinderHomeScreenState extends State<JobFinderHomeScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  final _bottomNavigationBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Home",
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(
    //     Icons.search,
    //     color: Color.fromARGB(205, 22, 68, 87),
    //   ),
    //   label: "Search",
    // ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.file_copy,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Applied",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Favorite",
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
            // Search(),
            AppliedJobs(),
            Favourite(),
            Profile(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 245, 248, 248),
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
