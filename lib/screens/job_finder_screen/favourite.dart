import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/helper/ui_helper.dart';
import 'package:recruiter/screens/job_finder_screen/job_helper/job_description.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Saved Jobs",
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
            stream: _firestore
                .collection("users")
                .doc(_auth.currentUser!.email.toString())
                .collection("savedJobs")
                .snapshots(),
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
                            elevation: 4,
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.white,
                                  width: 92,
                                  height: 138.2,
                                  child: Image.asset(
                                    "assets/images/iconGoogle.png",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(7),
                                          bottomRight: Radius.circular(7))),
                                  child: ListTile(
                                    onTap: () => Navigator.push(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return JobDescription(
                                          jobTitle: jobsData["title"],
                                          jobDescription:
                                              jobsData["description"],
                                          jobSalary: jobsData["salary"],
                                          jobSkills: jobsData["skills"],
                                          jobPostdate: jobsData["posted at"],
                                          jobEmail: jobsData["email"],
                                          jobsExperience:
                                              jobsData["experience required"],
                                          jobCompanyName:
                                              jobsData["company name"],
                                        );
                                      },
                                    )),
                                    title: Text(
                                      jobsData["title"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Company: ${jobsData["company name"]}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black87),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 3),
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  43, 158, 158, 158),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            'Salary: ₹${jobsData["salary"]}',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    145, 0, 0, 0)),
                                          ),
                                        ),
                                        Text(
                                          'Skills: ${jobsData["skills"]}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 60, 106, 176),
                                          ),
                                        ),
                                        Text(
                                          'postedDate: ${jobsData["posted at"]}',
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                        onPressed: () async {
                                          await _firestore
                                              .collection("users")
                                              .doc(_auth.currentUser!.email
                                                  .toString())
                                              .collection("savedJobs")
                                              .doc(
                                                  '${jobsData["title"]} ${jobsData["email"]}')
                                              .delete()
                                              .then((value) =>
                                                  UiHelper.showSnackbar(
                                                      context, "Added to fav"));
                                        },
                                        icon: const Icon(
                                          CupertinoIcons.bookmark_fill,
                                        )),
                                  ),
                                ))
                              ],
                            ),
                          );
                        }),
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
        ],
      )),
    );
  }
}
