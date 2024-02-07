// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/screens/forgot_password/forgotpassword.dart';
import 'package:recruiter/helper/ui_helper.dart';
import 'package:recruiter/screens/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  //Creating firebaseAuth instance
  final FirebaseAuth _mAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Center(
              child: Image.asset(
                "assets/images/login.png",
                height: 100,
                color: const Color.fromARGB(255, 85, 143, 151),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Recruiter",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 60,
                  fontFamily: "GreatVibes-Regular"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Hello",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Sign into your Account",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "Email*",
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Icon(
                        Icons.mail,
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
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 210),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ForgotPassword();
                          },
                        ));
                      },
                      child: const Text(
                        "Forgot Password?",
                        style:
                            TextStyle(color: Color.fromARGB(255, 163, 16, 6)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
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
                    child: const Text("Login"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Or Register using social Media",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                      ),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, '/PhoneNumberScreen'),
                        child: Image.network(
                          "https://cdn-icons-png.flaticon.com/128/300/300221.png",
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.network(
                        "https://cdn-icons-png.flaticon.com/128/724/724664.png",
                        height: 30,
                        cacheHeight: 60,
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 60, right: 10),
              color: const Color.fromARGB(36, 158, 158, 158),
              child: Row(
                children: [
                  const Text("Already have an account?"),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const SignUp();
                        },
                      ));
                    },
                    child: const Text(
                      " Register Now",
                      style: TextStyle(
                          color: Color.fromARGB(255, 85, 143, 151),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  void validateTextBox() {
    if (_emailController.text.toString().isEmpty) {
      UiHelper.showSnackbar(context, "Email Required");
    } else if (_passwordController.text.toString().isEmpty) {
      UiHelper.showSnackbar(context, "Enter Password");
    } else {
      login();
    }
  }

  void login() async {
    try {
      await _mAuth
          .signInWithEmailAndPassword(
              email: _emailController.text.toString(),
              password: _passwordController.text.toString())
          .then((value) =>
              Navigator.pushReplacementNamed(context, "/SelectRoleScreen"));
    } catch (e) {
      UiHelper.showSnackbar(context, e.toString());
    }
  }
}
