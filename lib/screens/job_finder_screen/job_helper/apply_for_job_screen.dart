import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:recruiter/helper/ui_helper.dart';

class ApplyForJobScreen extends StatefulWidget {
  const ApplyForJobScreen(
      {super.key, required this.jobEmail, required this.jobTitle});
  final String jobEmail;
  final String jobTitle;

  @override
  State<ApplyForJobScreen> createState() => _ApplyForJobScreenState();
}

class _ApplyForJobScreenState extends State<ApplyForJobScreen> {
  final TextEditingController _bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jobTitle),
      ),
      body: Column(children: [
        TextField(
          controller: _bodyController,
          decoration:
              const InputDecoration(hintText: "Why should we hire you?"),
        ),
        CupertinoButton(
          color: Colors.blue[100],
          child: const Text(
            "Submit Application",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () => sendEmail(),
        )
      ]),
    );
  }

  void sendEmail() async {
    final Email email = Email(
      body: _bodyController.text.toString(),
      subject: widget.jobTitle,
      recipients: [widget.jobEmail],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email).then((value) {
      UiHelper.showSnackbar(context, "Application Submitted");
      Navigator.pushReplacementNamed(context, '/JobFinderHomeScreen');
    });
  }
}
