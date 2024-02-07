// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recruiter/helper/ui_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final bool _passwordVisible = false;
  bool isChecked = false;

//image selected by user
  File? _pickedImage;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  //creating firebaseAuth instance
  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: const Color.fromARGB(103, 85, 143, 151),
        title: const Text(
          "Create Account",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 31),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 10,
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
                    showPhotoOption();
                  },
                  padding: EdgeInsets.zero,
                  child: _pickedImage == null
                      ? const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 85, 143, 151),
                          radius: 50,
                          child: Icon(
                            Icons.person_add,
                            size: 60,
                            color: Colors.white,
                          ))
                      : CircleAvatar(
                          backgroundImage: FileImage(_pickedImage!),
                          radius: 50,
                          child: const Icon(
                            null,
                            size: 50,
                          ))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(
                hintText: "Username*",
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(
                  Icons.person,
                  // color: Colors.grey,
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
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "Email*",
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(
                  Icons.mail,
                  //color: Colors.grey,
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
              obscureText: _passwordVisible,
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
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 85, 143, 151),
                  ),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const Text(
                  "I Read and agree to",
                  style: TextStyle(color: Colors.black26),
                ),
                const Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    color: Color.fromARGB(255, 85, 143, 151),
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => validateTextBox(),
              style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 85, 143, 151),
                  ),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
                  padding: const MaterialStatePropertyAll(EdgeInsets.only(
                      left: 90, right: 90, bottom: 15, top: 15))),
              child: const Text("Register"),
            ),
            const SizedBox(
              height: 55,
            ),
          ],
        )),
      ),
      bottomNavigationBar: Container(
        height: 50,
        //padding: const EdgeInsets.only(left: 60, right: 10),
        color: const Color.fromARGB(129, 158, 158, 158),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/LoginScreen');
              },
              child: const Text(
                " Login",
                style: TextStyle(
                    color: Color.fromARGB(255, 85, 143, 151),
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

//To show dialog to choose gallery or camera option
  void showPhotoOption() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              ListTile(
                onTap: () {
                  print("gallery clicked");
                  selectImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                title: const Text("Select from gallery"),
                leading: const Icon(Icons.photo_album),
              ),
              ListTile(
                onTap: () {
                  print("camera clicked");
                  selectImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                title: const Text("Take a Photo"),
                leading: const Icon(Icons.camera),
              ),
            ]),
          );
        });
  }

  void selectImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        // Crop the image if needed
        final croppedImage = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        );

        setState(() {
          if (croppedImage != null) {
            _pickedImage = File(croppedImage.path);
          } else {
            UiHelper.showSnackbar(context, "Error cropping image");
          }
        });
      }
    } catch (e) {
      UiHelper.showSnackbar(context, "Error picking image: $e");
    }
  }

  void validateTextBox() {
    if (_userNameController.text.toString().isEmpty) {
      UiHelper.showSnackbar(context, "UserName Required");
    } else if (_emailController.text.toString().isEmpty) {
      UiHelper.showSnackbar(context, "Email Id Required");
    } else if (!isValidEmail(_emailController.text.toString())) {
      UiHelper.showSnackbar(context, "Enter Valid Email Id");
    } else if (_passwordController.text.toString().isEmpty) {
      UiHelper.showSnackbar(context, "Create Password");
    } else if (_passwordController.text.toString().length < 8) {
      UiHelper.showSnackbar(context, "Enter Strong Password(Min 8 chars)");
    } else if (_cityController.text.toString().isEmpty) {
      UiHelper.showSnackbar(context, "Enter your City Name");
    } else {
      addUser();
    }
  }

  //Checking email format
  bool isValidEmail(String email) {
    // Regular expression for a simple email validation
    String emailRegex = r'^[a-zA-Z_]+[\w-]*@(gmail\.)+[com]';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  //To add user in firestore database
  Future<void> addUser() async {
    String userName = _userNameController.text.toString();
    String email = _emailController.text.toString();
    String password = _passwordController.text.toString();
    String city = _cityController.text.toString();

    //To upload photo
    final imageBytes = await _pickedImage!.readAsBytes();
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("profilePic")
        .child("$userName profilePic")
        .putData(imageBytes);

    TaskSnapshot snapshot = await uploadTask;

    String? imageUrl = await snapshot.ref.getDownloadURL();
    //To upload other data
    Map<String, dynamic> addUserData = {
      "username": userName,
      "email": email,
      "password": password,
      "city": city,
      "profilePic": imageUrl
    };
    //Adding data to firestore
    await _firestore
        .collection("users")
        .doc(email)
        .set(addUserData)
        .then((value) {
      signUp(email, password);
      UiHelper.showSnackbar(context, "User Added Successfully");
    });
  }

  //To create user in firebase auth
  Future<void> signUp(String email, String password) async {
    await _mAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    Navigator.pushReplacementNamed(context, "/LoginScreen");
  }
}
