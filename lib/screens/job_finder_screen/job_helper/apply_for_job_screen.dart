// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'package:recruiter/helper/ui_helper.dart';
import 'package:file_picker/file_picker.dart';

class ApplyForJobScreen extends StatefulWidget {
  const ApplyForJobScreen(
      {super.key, required this.jobEmail, required this.jobTitle});
  final String jobEmail;
  final String jobTitle;

  @override
  State<ApplyForJobScreen> createState() => _ApplyForJobScreenState();
}

class _ApplyForJobScreenState extends State<ApplyForJobScreen> {
  final TextEditingController _hireController = TextEditingController();
  final TextEditingController _noController = TextEditingController();
  File? _pickedFile;
  bool _check = false;
  bool _visibleTextBox = false;
  String selectAvailability = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jobTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 7, left: 7),
          child: Column(children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Why should you be hired for this role?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _hireController,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Your Answer!!"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Your Availability",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            Row(
              children: [
                Radio(
                  value: "Yes, I am available to join immediately",
                  groupValue: selectAvailability,
                  onChanged: (value) => setState(() {
                    selectAvailability = value.toString();
                    _visibleTextBox = false;
                    _noController.text = "";
                  }),
                ),
                const Text(
                  "Yes, I am available to join immediately",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: "No, ",
                  groupValue: selectAvailability,
                  onChanged: (value) => setState(() {
                    selectAvailability = value.toString();
                    _visibleTextBox = true;
                    print(_noController.text.toString());
                  }),
                ),
                const Text(
                  "No, ",
                  style: TextStyle(fontSize: 15),
                ),
                const Text(
                  "(Specify your reason)",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            Visibility(
              visible: _visibleTextBox,
              child: Container(
                height: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _noController,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Your Answer!!"),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Upload your resume",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: _pickPDF,
              child: Container(
                height: MediaQuery.of(context).size.height / 11,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _check
                        ? Row(
                            children: [
                              const Text(
                                "Uploaded Successfully",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                              IconButton(
                                  onPressed: () => setState(() {
                                        _check = false;
                                        _pickedFile = null;
                                      }),
                                  icon: const Icon(
                                      CupertinoIcons.clear_thick_circled))
                            ],
                          )
                        : const Row(
                            children: [
                              Icon(
                                Icons.upload_sharp,
                                size: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Upload file",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              color: const Color.fromARGB(255, 85, 143, 151),
              child: const Text(
                "Submit Application",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                validate();
              },
            ),
          ]),
        ),
      ),
    );
  }

  void validate() {
    if (_hireController.text.isEmpty) {
      UiHelper.showSnackbar(context, "Why should you be hired?");
    } else if (selectAvailability.isEmpty) {
      UiHelper.showSnackbar(context, "Are you available to join immediately?");
    } else if (_pickedFile == null) {
      UiHelper.showSnackbar(context, "Upload your resume");
    } else {
      sendEmail();
    }
  }

  void sendEmail() async {
    String body =
        "${_hireController.text.toString()}\n\n\nAvailability: $selectAvailability";

    if (_visibleTextBox) {
      // Include the value of _noController when "No" is selected
      body += _noController.text;
    }
    final Email email = Email(
      body: body,
      subject: widget.jobTitle,
      recipients: [widget.jobEmail],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      attachmentPaths: [_pickedFile!.path],
      isHTML: false,
    );
    await FlutterEmailSender.send(email).then((value) {
      UiHelper.showSnackbar(context, "Application Submitted");
      Navigator.pushReplacementNamed(context, '/JobFinderHomeScreen');
    });
  }

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      // Store the picked PDF file in the variable
      _pickedFile = File(result.files.first.path!);
      setState(() {
        _check = true;
      });

      // Handle other aspects if needed, e.g., displaying the file name
      print('File picked: ${result.files.first.name}');
    } else {
      UiHelper.showSnackbar(context, "Choose Again");
    }
  }
}
