import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController _skillsController = TextEditingController();
  //Database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(hintText: "Description"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _skillsController,
              decoration: const InputDecoration(hintText: "Skills Required"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => addJobs(), child: const Text("Add Job")),
          ],
        ),
      ),
    );
  }

  void addJobs() async {
    String title = _titleController.text.toString();
    String description = _descriptionController.text.toString();
    String skills = _skillsController.text.toString();

    //Add data to map
    Map<String, dynamic> addJobs = {
      "titlle": title,
      "description": description,
      "skills": skills
    };

    //Adding to database
    await _firestore
        .collection("Jobs")
        .add(addJobs)
        .then((value) => UiHelper.showSnackbar(context, "Job Added"));
  }
}
