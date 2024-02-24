import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/helper/ui_helper.dart';
import 'package:recruiter/screens/job_finder_screen/job_helper/on_tap_job_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //bool _liked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color.fromARGB(41, 85, 143, 151),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Recruiter",
                style: TextStyle(
                    color: Color.fromARGB(255, 85, 143, 151),
                    fontSize: 40,
                    fontFamily: "GreatVibes-Regular"),
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection("Jobs").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> jobsData =
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            onTap: () =>
                                Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return OnTapJobScreen(
                                  jobTitle: jobsData["title"],
                                  jobDescription: jobsData["description"],
                                  jobSalary: jobsData["salary"],
                                  jobSkills: jobsData["skills"],
                                  jobPostdate: jobsData["posted at"],
                                  jobEmail: jobsData["email"],
                                  jobsExperience:
                                      jobsData["experience required"],
                                  jobCompanyName: jobsData["company name"],
                                );
                              },
                            )),
                            title: Text(jobsData["title"]),
                            subtitle: Text(jobsData["description"]),
                            trailing: IconButton(
                                onPressed: () async {
                                  Map<String, dynamic> likedJobs = {
                                    "title": jobsData["title"],
                                    "description": jobsData["description"],
                                    "salary": jobsData["salary"],
                                    "skills": jobsData["skills"],
                                    "posted at": jobsData["posted at"],
                                    "email": jobsData["email"],
                                    "experience required":
                                        jobsData["experience required"],
                                  };
                                  await _firestore
                                      .collection("likedJobs")
                                      .doc(
                                          '${jobsData["title"]} ${jobsData["email"]}')
                                      .set(likedJobs)
                                      .then((value) => UiHelper.showSnackbar(
                                          context, "Added to fav"));
                                },
                                icon: const Icon(
                                  CupertinoIcons.heart,
                                )),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Text("No Jobs Found");
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ]),
      ),
    );
  }
}
