import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/screens/job_finder_screen/job_finder_home_screen.dart';
import 'package:recruiter/screens/job_provider_screens/job_provider_home.dart';

class SelectRole extends StatefulWidget {
  const SelectRole({
    super.key,
  });

  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/128/8462/8462263.png",
                    color: Colors.blue.shade900,
                    height: 60,
                  ),
                  Text(
                    "Recruiter",
                    style: TextStyle(color: Colors.blue.shade900, fontSize: 23),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "India's #1 Blue & Grey Collar Job Portal",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 200,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(children: [
                        Image.asset(
                          "assets/images/job_finder.jpg",
                          fit: BoxFit.fill,
                          width: 350,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color.fromARGB(115, 23, 95, 251),
                                const Color.fromARGB(79, 128, 150, 216)
                                    .withOpacity(0.7)
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 80, left: 160, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "I Want \na job",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w500),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const JobFinderHomeScreen()));
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(children: [
                        Image.asset(
                          "assets/images/job_provider.jpg",
                          fit: BoxFit.fill,
                          width: 350,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color.fromARGB(115, 0, 81, 255),
                                const Color.fromARGB(79, 128, 150, 216)
                                    .withOpacity(0.7)
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 80, left: 160, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "I Want \nto hire",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 33,
                                fontWeight: FontWeight.w500),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const JobProviderHomeScreen()));
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
