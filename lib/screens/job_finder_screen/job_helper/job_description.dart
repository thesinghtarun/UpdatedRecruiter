import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/screens/job_finder_screen/job_helper/apply_for_job_screen.dart';

class JobDescription extends StatefulWidget {
  const JobDescription(
      {super.key,
      required this.jobTitle,
      required this.jobDescription,
      required this.jobSalary,
      required this.jobPostdate,
      required this.jobSkills,
      required this.jobsExperience,
      required this.jobEmail,
      required this.jobCompanyName});
  final String jobTitle;
  final String jobEmail;
  final String jobDescription;
  final String jobSalary;
  final String jobPostdate;
  final String jobSkills;
  final String jobsExperience;
  final String jobCompanyName;

  @override
  State<JobDescription> createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription> {
  @override
  Widget build(BuildContext context) {
    String skills = widget.jobSkills;
    String formattedSkills = skills.replaceAll(",", "\n");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jobTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height / 3.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Image.asset("assets/images/lock.png"),
              ),
              const SizedBox(
                height: 17,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Company Name: ",
                          style: TextStyle(
                              color: Colors.green[300],
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.jobCompanyName} ",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Salary: ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 170, 59),
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.jobSalary} ",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 5.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 5, top: 5),
                            child: Text(
                              "Job Description: ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 10),
                            child: Text(widget.jobDescription),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 5.5,
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 5, top: 5),
                              child: Text(
                                "Skills: ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 100, 11, 243)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0, left: 10),
                              child: Text(
                                formattedSkills,
                                style: const TextStyle(
                                    color: Color.fromARGB(183, 218, 74, 196)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ApplyForJobScreen(
                              jobEmail: widget.jobEmail,
                              jobTitle: widget.jobTitle,
                              jobDescription: widget.jobDescription,
                              jobCompanyName: widget.jobCompanyName,
                              jobSalary: widget.jobSalary,
                              jobSkills: widget.jobSkills,
                              jobsExperience: widget.jobsExperience,
                              jobPostdate: widget.jobPostdate))),
                  style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 85, 143, 151),
                      ),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                      padding: const MaterialStatePropertyAll(EdgeInsets.only(
                          left: 60, right: 60, bottom: 10, top: 10))),
                  child: const Text(
                    "Apply",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
