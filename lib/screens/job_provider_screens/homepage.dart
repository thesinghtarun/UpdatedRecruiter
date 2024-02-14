import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          TextField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffix: ElevatedButton(
                  child: const Text("Search"),
                  onPressed: () => print("Search"),
                )),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection("Jobs").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> jobsData =
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                        return ListTile(
                          title: Text(jobsData["title"]),
                          subtitle: Text(jobsData["description"]),
                        );
                      },
                    ),
                  );
                } else {
                  return Text("No Jobs Found");
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ]),
      ),
    );
  }
}
