import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/helper/ui_helper.dart';
import 'package:recruiter/screens/login.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Forget Password",
                style: TextStyle(
                    color: Color.fromARGB(255, 85, 143, 151),
                    fontSize: 40,
                    fontFamily: "GreatVibes-Regular"),
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          const Text(
            "Email",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  prefixIcon: Icon(Icons.email), border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => validateTextBox(),
              style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 85, 143, 151),
                  ),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
                  padding: const MaterialStatePropertyAll(EdgeInsets.only(
                      left: 60, right: 60, bottom: 10, top: 10))),
              child: const Text(
                "Reset Password",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateTextBox() {
    if (_emailController.text.isEmpty) {
      UiHelper.showSnackbar(context, "Enter Email Id");
    } else if (!isValidEmail(_emailController.text)) {
      UiHelper.showSnackbar(context, "Enter Valid Email");
    } else {
      _sendResetEmail();
    }
  }

  void _sendResetEmail() {
    _auth.sendPasswordResetEmail(email: _emailController.text).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login())));
  }
}

bool isValidEmail(String email) {
  // Regular expression for a simple email validation
  String emailRegex = r'^[a-zA-Z_]+[\w-]*@(gmail\.)+[com]';
  RegExp regex = RegExp(emailRegex);
  return regex.hasMatch(email);
}
