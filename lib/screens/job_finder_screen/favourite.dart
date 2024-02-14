import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/helper/ui_helper.dart';
import 'package:recruiter/screens/job_finder_screen/job_helper/on_tap_job_screen.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("likedJobs").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data != null) {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> jobsData = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return OnTapJobScreen(
                              jobTitle: jobsData["title"],
                              jobDescription: jobsData["description"],
                              jobSalary: jobsData["salary"],
                              jobSkills: jobsData["skills"],
                              jobPostdate: jobsData["posted at"],
                              jobEmail: jobsData["email"],
                              jobsExperience: jobsData["experience required"],
                            );
                          },
                        )),
                        title: Text(jobsData["title"]),
                        subtitle: Text(jobsData["description"]),
                        trailing: IconButton(
                            onPressed: () async {
                              await _firestore
                                  .collection("likedJobs")
                                  .doc(
                                      '${jobsData["title"]} ${jobsData["email"]}')
                                  .delete()
                                  .then((value) => UiHelper.showSnackbar(
                                      context, "Removed"));
                              print("Removed from db");
                            },
                            icon: const Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.red,
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
      )),
    );
  }
}
