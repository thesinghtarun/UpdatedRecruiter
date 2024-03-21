import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> jobDocs = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
              decoration: InputDecoration(
                hintText: 'Search Jobs',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) {
                _search(value);
              },
            ),
          ),
          Expanded(
            child: jobDocs.isEmpty
                ? Center(
                    child: Text("hello"),
                    // child: Lottie.asset(
                    //   'assets/animation_lmm6bvuc.json',
                    //   width: 350,
                    //   repeat: true,
                    //   reverse: false,
                    //   animate: true,
                    // ),
                  )
                : ListView.builder(
                    itemCount: jobDocs.length,
                    itemBuilder: (context, index) {
                      var job = jobDocs[index].data() as Map<String, dynamic>;
                      var jobId = jobDocs[index].id;

                      var jobTitle = job['jobTitle'] as String? ??
                          'Job Title Not Provided';
                      var companyName = job['companyName'] as String? ??
                          'Company Name Not Provided';
                      var salary =
                          job['salary'] as String? ?? 'Salary Not Provided';
                      var postedDate =
                          job['postedDate'] as String? ?? 'no date';
                      var skills = job['skills'] as List<dynamic>?;
                      var skillsText = skills != null
                          ? skills.join(', ')
                          : 'Skills Not Provided';
                      return Card(
                        // color: salary,
                        margin: EdgeInsets.all(6),
                        // padding: EdgeInsets.all(16),
                        // decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 235, 235),
                        elevation: 1,
                        //   borderRadius: BorderRadius.circular(5),
                        // ),
                        child: ListTile(
                          leading: Icon(
                            Icons.search,
                            size: 30,
                          ),
                          title: Text(
                            jobTitle,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Company: $companyName',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black45),
                              ),
                            ],
                          ),
                          onTap: () => print("jobs"),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _search(String query) async {
    final CollectionReference jobsCollection =
        FirebaseFirestore.instance.collection('jobs');

    jobsCollection
        .where('jobTitle' == _searchController.text)
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        jobDocs = querySnapshot.docs;
        // _addToRecentSearches(query);
      });
    }).catchError((error) {
      print("Error getting documents: $error");
    });
  }
}
