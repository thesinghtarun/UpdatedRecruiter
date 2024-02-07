import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'signup.dart';

User? user;

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool r1 = false;
  bool r2 = false;
  bool r3 = false;
  final List<String> imageUrls = [
    'https://image-assets.eu-2.volcanic.cloud/api/v1/assets/images/3e1574c8213af4cb5337bdedb8cbab75?fallback=true&format=webp&size=600x300%3C&version=latest',
    'https://img.freepik.com/premium-vector/job-application-form_87720-231.jpg?size=626&ext=jpg',
    'https://recruitingdaily.com/wp-content/uploads/2021/09/Fotolia_124826197_S.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image.network(
            //     "https://img.freepik.com/premium-vector/modern-coffee-shop-with-furniture_122154-706.jpg?w=2000"),
            CarouselSlider(
              options: CarouselOptions(
                height: 450,
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
              ),
              items: imageUrls.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Recruiter",
              style: TextStyle(
                  fontSize: 87,
                  color: Color.fromARGB(255, 10, 130, 138),
                  fontWeight: FontWeight.w400,
                  fontFamily: "GreatVibes-Regular"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "GET YOUR DREAM JOB",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "JosefinSlab",
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 10,
            ),
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 29, fontFamily: "HennyPenny"),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      r1 = !r1;
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const SignUp();
                        },
                      ));
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 10, 130, 138),
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Color.fromARGB(255, 10, 130, 138),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      r2 = !r2;
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const Login();
                        },
                      ));
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 10, 130, 138),
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color.fromARGB(255, 10, 130, 138),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
