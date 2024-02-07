import 'package:flutter/material.dart';
import 'package:recruiter/screens/job_provider_screens/add.dart';
import 'package:recruiter/screens/job_provider_screens/category.dart';
import 'package:recruiter/screens/job_provider_screens/favourite.dart';
import 'package:recruiter/screens/job_provider_screens/homepage.dart';
import 'package:recruiter/screens/job_provider_screens/profile.dart';

class JobProviderHomeScreen extends StatefulWidget {
  const JobProviderHomeScreen({super.key});

  @override
  State<JobProviderHomeScreen> createState() => _JobProviderHomeScreenState();
}

class _JobProviderHomeScreenState extends State<JobProviderHomeScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  final _bottomNavigationBarItem = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Favorite",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add_box_rounded,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Add",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.category,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Category",
    ),
    BottomNavigationBarItem(
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
          children: [
            HomePage(),
            Favourite(),
            Add(),
            Category(),
            Profile(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 85, 143, 151),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,

          currentIndex: _currentIndex,
          items: _bottomNavigationBarItem,
          onTap: (value) {
            _pageController.animateToPage(value,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
          // type: BottomNavigationBarType.fixed,
        ));
  }
}
