import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatWithJobProvider extends StatefulWidget {
  const ChatWithJobProvider({super.key, required this.jobEmail});
  final String jobEmail;

  @override
  State<ChatWithJobProvider> createState() => _ChatWithJobProviderState();
}

class _ChatWithJobProviderState extends State<ChatWithJobProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.jobEmail,
        style: const TextStyle(fontSize: 16),
      )),
      body: const Center(
        child: Text(
          "Coming Soon..",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
