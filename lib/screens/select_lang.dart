import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/screens/welcome.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset("assets/images/welcomeScreen.png"),
          const Text(
            "Recruiter",
            style: TextStyle(
                color: Color.fromARGB(255, 85, 143, 151),
                fontSize: 60,
                fontFamily: "GreatVibes-Regular"),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    color: Color.fromARGB(255, 200, 237, 242),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Choose Your Language",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CupertinoButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 120, vertical: 10),
                          color: Colors.white,
                          child: const Text(
                            "हिंदी",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 146, 212, 221),
                            ),
                          ),
                          onPressed: () => print("Hindi Clicked")),
                      const SizedBox(
                        height: 30,
                      ),
                      CupertinoButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 14),
                          color: const Color.fromARGB(255, 146, 212, 221),
                          child: const Text(
                            "English",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => print("English Clicked")),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: CupertinoButton(
          color: const Color.fromARGB(255, 85, 143, 151),
          child: const Text(
            "Get Started",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Welcome()))),
    );
  }
}
