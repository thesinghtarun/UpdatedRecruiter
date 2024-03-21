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
import 'package:recruiter/screens/login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  //image selected by user
  File? _pickedImage;

  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Profile",
                      style: TextStyle(
                          color: Color.fromARGB(255, 85, 143, 151),
                          fontSize: 40,
                          fontFamily: "GreatVibes-Regular"),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () => _auth.signOut().then((value) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: _firestore
                  .collection("users")
                  .doc(_auth.currentUser!.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    Map<String, dynamic>? userData =
                        snapshot.data!.data() as Map<String, dynamic>?;

                    if (userData != null) {
                      // Set initial values to text controllers
                      _userNameController.text = userData["username"];
                      _passwordController.text = userData["password"];
                      _cityController.text = userData["city"];
                      return Column(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 65,
                                  backgroundImage: _pickedImage != null
                                      ? Image.file(_pickedImage!)
                                          .image // Show selected image if available
                                      : NetworkImage(
                                          userData[
                                              "profilePic"], // Otherwise, show the existing profile image
                                        ),
                                ),
                                Positioned(
                                  right: 7,
                                  bottom: 1,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black45,
                                    child: IconButton(
                                        onPressed: () => showPhotoOption(),
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(userData["email"]),
                          const SizedBox(
                            height: 7,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "User Name",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
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
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: _passwordVisible ? true : false,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.password),
                                  suffixIcon: IconButton(
                                      onPressed: () => _passwordVisible
                                          ? setState(() {
                                              _passwordVisible = false;
                                            })
                                          : setState(() {
                                              _passwordVisible = true;
                                            }),
                                      icon: _passwordVisible
                                          ? const Icon(Icons.remove_red_eye)
                                          : const Icon(
                                              CupertinoIcons.eye_slash)),
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "City",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
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
                            height: 15,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () => _validate(),
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
                                "Update",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Text("No User Data Found");
                    }
                  } else {
                    return const Text("No User Data Found");
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
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

  void _updateUserData() async {
    try {
      // Check if a new image has been selected
      if (_pickedImage != null) {
        // Upload the new image to storage
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child("profilePic")
            .child("${_auth.currentUser!.uid}.jpg");
        await storageReference.putFile(_pickedImage!);

        // Get the download URL of the uploaded image
        final String downloadURL = await storageReference.getDownloadURL();

        // Update the profile picture URL in Firestore
        await _firestore
            .collection("users")
            .doc(_auth.currentUser!.email)
            .update({"profilePic": downloadURL}).then(
                (value) => UiHelper.showSnackbar(context, "Done"));
      }
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.email)
          .update({
        "username": _userNameController.text,
        "password": _passwordController.text,
        "city": _cityController.text,
      }).then((value) => UiHelper.showSnackbar(context, "Done"));
    } catch (error) {
      UiHelper.showSnackbar(context, error.toString());
    }
  }

  void _validate() {
    if (_userNameController.text.isEmpty) {
      UiHelper.showSnackbar(context, "Enter UserName");
    } else if (_passwordController.text.isEmpty) {
      UiHelper.showSnackbar(context, "Enter Password");
    } else if (_cityController.text.isEmpty) {
      UiHelper.showSnackbar(context, "Enter City");
    } else {
      _updateUserData();
    }
  }
}
