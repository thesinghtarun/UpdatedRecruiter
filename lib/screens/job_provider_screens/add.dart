import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/helper/ui_helper.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _profileLinkController = TextEditingController();

  //Database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Post a Job',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 85, 143, 151),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Job Title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter job title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Job Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Enter job description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Company Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _companyNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter company name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Salary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _salaryController,
                  decoration: const InputDecoration(
                    hintText: 'Enter salary',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Skills',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _skillsController,
                  decoration: const InputDecoration(
                    hintText: 'Enter required skills (comma-separated)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                const Text(
                  'Experience Required',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _experienceController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Experience Required',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => validate(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 85, 143, 151),
                    ),
                    child: const Text(
                      'Post Job',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validate() {
    if (_titleController.text.toString().isEmpty) {
      UiHelper.showSnackbar(context, "Enter job title");
    } else if (_descriptionController.text.isEmpty) {
      UiHelper.showSnackbar(context, "Enter job description");
    } else if (_companyNameController.text.isEmpty) {
      UiHelper.showSnackbar(context, "Enter your company name");
    } else if (_salaryController.text.isEmpty) {
      UiHelper.showSnackbar(context, "Enter salary");
    } else if (_skillsController.text.isEmpty) {
      UiHelper.showSnackbar(context, "Enter skills");
    } else if (_experienceController.text.isEmpty) {
      UiHelper.showSnackbar(context, "Enter experience required");
    } else {
      addJobs();
    }
  }

  void addJobs() async {
    String title = _titleController.text.toString().trim();
    String description = _descriptionController.text.toString().trim();
    String companyName = _companyNameController.text.toString().trim();
    String skills = _skillsController.text.toString().trim();
    String email = FirebaseAuth.instance.currentUser!.email.toString().trim();
    String time = getCurrentDateTime();
    String experience = _experienceController.text.toString().trim();
    String salary = _salaryController.text.toString().trim();

    //Add data to map
    Map<String, dynamic> addJobs = {
      "title": title,
      "description": description,
      "skills": skills,
      "email": email,
      "posted at": time,
      "salary": salary,
      "experience required": experience,
      "company name": companyName,
      "profilePic url": null
    };

    //Adding to database
    await _firestore.collection("Jobs").add(addJobs).then(
      (value) {
        UiHelper.showSnackbar(context, "Job Added");
        _titleController.text = "";
        _descriptionController.text = "";
        _companyNameController.text = "";
        _salaryController.text = "";
        _skillsController.text = "";
        _experienceController.text = "";
      },
    );
  }

  static String getCurrentDateTime() {
    DateTime now = DateTime.now();
    return now.toString(); // Example output: 2024-02-07 16:49:33.123456
  }
}
