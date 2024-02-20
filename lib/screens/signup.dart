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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 85, 143, 151),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 105))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    "Create your Account",
                    style: TextStyle(fontSize: 18, color: Colors.white54),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                      elevation: 7,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        height: MediaQuery.of(context).size.height / 1.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                "Recruiter",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: "GreatVibes-Regular"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: CupertinoButton(
                                  onPressed: () {
                                    showPhotoOption();
                                  },
                                  padding: EdgeInsets.zero,
                                  child: _pickedImage == null
                                      ? const CircleAvatar(
                                          backgroundColor:
                                              Color.fromARGB(255, 85, 143, 151),
                                          radius: 40,
                                          child: Icon(
                                            Icons.person_add,
                                            size: 40,
                                            color: Colors.white,
                                          ))
                                      : CircleAvatar(
                                          backgroundImage:
                                              FileImage(_pickedImage!),
                                          radius: 40,
                                          child: const Icon(
                                            null,
                                            size: 40,
                                          ))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "User Name",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: _userNameController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: InputBorder.none),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    border: InputBorder.none),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.password),
                                    border: InputBorder.none),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "City",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: _cityController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.location_city),
                                    border: InputBorder.none),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account?",
                                  style: TextStyle(fontSize: 17),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                    onTap: () => Navigator.pushReplacementNamed(
                                        context, '/Login'),
                                    child: const Text(
                                      "SIGN IN",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () => validateTextBox(),
                                style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                      Color.fromARGB(255, 85, 143, 151),
                                    ),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40))),
                                    padding: const MaterialStatePropertyAll(
                                        EdgeInsets.only(
                                            left: 60,
                                            right: 60,
                                            bottom: 10,
                                            top: 10))),
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
