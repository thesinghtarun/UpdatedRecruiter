import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title, required this.emailId});
  final String title;
  final String emailId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String currentUserGmail = _mAuth.currentUser!.email.toString();
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 3),
            child: SingleChildScrollView(
              child: Container(
                color: Colors.black12,
                height: MediaQuery.of(context).size.height / 14,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Write a message",
                      suffixIcon: IconButton(
                        onPressed: () => print("clicked"),
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blue,
                          size: 27,
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
