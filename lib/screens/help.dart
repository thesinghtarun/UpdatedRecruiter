import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  bool _newUser = false;
  bool _existingUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const Text(
            "Login & Registration Guide",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, top: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 194, 234, 239),
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: const Column(
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Welcome to Our Talent Hub!",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 19),
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "🌟 Why Register? 🌟",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 19),
                      )),
                  SizedBox(
                    height: 7,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Unlock exclusive access to top talent.\nConnect with skilled professionals.\nDiscover your next star hire",
                        style: TextStyle(
                            fontWeight: FontWeight.w200, fontSize: 19),
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _newUser
                        ? setState(() {
                            _newUser = false;
                          })
                        : setState(() {
                            _newUser = true;
                          });
                    setState(() {
                      _existingUser = false;
                    });
                    print("New User");
                    print(_newUser);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.1,
                    height: MediaQuery.of(context).size.height / 8,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 194, 234, 239),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "1. New User Registration:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "Click here",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _existingUser
                        ? setState(() {
                            _existingUser = false;
                          })
                        : setState(() {
                            _existingUser = true;
                          });
                    setState(() {
                      _newUser = false;
                    });

                    print(_existingUser);
                    print("Existing User");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.1,
                    height: MediaQuery.of(context).size.height / 8,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 194, 234, 239),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "2. Existing User Login:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "Click here",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _newUser ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, top: 10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 194, 234, 239),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "New User Registration",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Center(
                        child: Text(
                          "Registration Steps:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Email Address:",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Provide a valid email address.\nThis will be your unique username for login.\nDouble-check for accuracy.",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Create a Password:",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Provide your secret key to unlock your recruiter dashboard.\nRemember, security matters! Use a strong password.\nMix uppercase, lowercase, numbers, and special characters.\nAvoid using easily guessable information (like “password123”).",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Phone Number:",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Add your contact digits.\nWe promise not to spam you (unless it’s about job opportunities).",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Terms and Conditions:",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Read the fine print (yes, we know it’s long).\nAccept our virtual handshake.\nWe’re in this together!",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Register Button:",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Click to create your recruiter account.\nCongratulations! You’re now part of our recruiter family.",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  )),
            ),
          ),
          Visibility(
            visible: _existingUser ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, top: 10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 194, 234, 239),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        "Existing User Login",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                      Center(
                          child: Text(
                        "Welcome Back!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Username or Email:",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Enter your registered email address or username.\nIf you’ve forgotten your username, use your email.\nDouble-check for typos!",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Password:",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Provide your secret key to unlock your recruiter dashboard.\nRemember, security matters! Use a strong password.\nMix uppercase, lowercase, numbers, and special characters.\nAvoid using easily guessable information (like “password123”).",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Forgot Password?:",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Click the link if memory fails you.\nWe’ll send a OTP to your registered Phone Number.\nyou will get the OTP to Update your Password.\nNew page will appear for you to set your new paassword.",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Login Button:",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Click to access your recruiter account.\nWelcome back to the world of talent acquisition!",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Questions or Assistance?",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Our support team is here for you.\nReach out if you need help",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      )),
    );
  }
}
