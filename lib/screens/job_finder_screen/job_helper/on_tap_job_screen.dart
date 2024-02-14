import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:recruiter/helper/ui_helper.dart';
import 'package:recruiter/screens/job_finder_screen/job_helper/apply_for_job_screen.dart';

class OnTapJobScreen extends StatefulWidget {
  const OnTapJobScreen(
      {super.key,
      required this.jobTitle,
      required this.jobDescription,
      required this.jobSalary,
      required this.jobPostdate,
      required this.jobSkills,
      required this.jobsExperience,
      required this.jobEmail});
  final String jobTitle;
  final String jobDescription;
  final String jobSalary;
  final String jobPostdate;
  final String jobSkills;
  final String jobsExperience;
  final String jobEmail;

  @override
  State<OnTapJobScreen> createState() => _OnTapJobScreenState();
}

class _OnTapJobScreenState extends State<OnTapJobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jobTitle),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Description: ${widget.jobDescription}",
              style: const TextStyle(fontSize: 21),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Skills: ${widget.jobSkills}",
              style: const TextStyle(fontSize: 21),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Experience Required: ${widget.jobsExperience}",
              style: const TextStyle(fontSize: 21),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Salary: ${widget.jobSalary}",
              style: const TextStyle(fontSize: 21),
            ),
            const SizedBox(
              height: 30,
            ),
            CupertinoButton(
              color: Colors.blue[100],
              child: const Text(
                "Submit Application",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ApplyForJobScreen(
                      jobEmail: widget.jobEmail, jobTitle: widget.jobTitle);
                }));
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.blue[100],
        child: Text(
          " ${widget.jobEmail}",
          style: const TextStyle(fontSize: 21),
        ),
      ),
    );
  }
}
