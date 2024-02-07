import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final FirebaseAuth _mAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Recruiter",
              style: TextStyle(
                  color: Color.fromARGB(255, 85, 143, 151),
                  fontSize: 60,
                  fontFamily: "GreatVibes-Regular"),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CupertinoButton(
                  onPressed: () {
                    print("Image Picker");
                  },
                  padding: EdgeInsets.zero,
                  child: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 85, 143, 151),
                      radius: 50,
                      child: Icon(
                        Icons.person_add,
                        size: 60,
                        color: Colors.white,
                      ))),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              _mAuth.currentUser!.email.toString(),
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(
                hintText: "Username*",
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(
                  Icons.person,
                  size: 20,
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
              cursorColor: Colors.grey,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              //obscureText: _passwordVisible,
              decoration: const InputDecoration(
                hintText: "Password*",
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(Icons.password),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
              cursorColor: Colors.grey,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                hintText: "City*",
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(
                  Icons.location_city,
                  //color: Colors.grey,
                  size: 20,
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
              cursorColor: Colors.grey,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => print("Updated"),
              style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 85, 143, 151),
                  ),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
                  padding: const MaterialStatePropertyAll(EdgeInsets.only(
                      left: 90, right: 90, bottom: 15, top: 15))),
              child: const Text("Update"),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => signOut(),
                  style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color.fromARGB(122, 244, 132, 104),
                      ),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                      padding: const MaterialStatePropertyAll(EdgeInsets.only(
                          left: 60, right: 60, bottom: 15, top: 15))),
                  child: const Text("Logout"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void signOut() async {
    await _mAuth.signOut().then(
        (value) => Navigator.pushReplacementNamed(context, "/LoginScreen"));
  }
}
