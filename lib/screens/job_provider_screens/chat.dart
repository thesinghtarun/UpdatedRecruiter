import 'package:flutter/material.dart';
import 'package:recruiter/helper/ui_helper.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 85, 143, 151),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(12, 22, 12, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Chat",
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(255, 255, 255, 255)),
                    child: const Icon(
                      Icons.search,
                      size: 26,
                      color: Color.fromARGB(255, 85, 143, 151),
                    )),
              ],
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: ListView.builder(
                  itemCount: 115,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        onTap: () => UiHelper.showSnackbar(context, "Hey"),
                        title: const Text("Tarun"),
                        leading: const Icon(Icons.question_answer),
                        subtitle: const Text("Hey"),
                        trailing: const Text("3:00"),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
