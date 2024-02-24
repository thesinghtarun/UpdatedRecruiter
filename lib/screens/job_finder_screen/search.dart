import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: TextField(
          decoration: InputDecoration(
              hintText: "Search Jobs",
              prefixIcon: const Icon(Icons.search),
              suffix: ElevatedButton(
                child: const Text("Search"),
                onPressed: () => print("Search"),
              )),
        ),
      ),
    );
  }
}
