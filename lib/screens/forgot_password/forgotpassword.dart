import 'package:flutter/material.dart';
import 'package:recruiter/screens/forgot_password/verification.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Image.asset(
                "assets/images/lock.png",
                height: 100,
              )),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "FORGET",
                style: TextStyle(fontSize: 28, fontFamily: "Merriweather"),
              ),
              const Text(
                "PASSWORD",
                style: TextStyle(fontSize: 28, fontFamily: "Merriweather"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Provide your account's email for which you want\n                     to reset your passeord!",
                style: TextStyle(color: Colors.black87),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40, right: 10, left: 10),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Phone Number',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text('+91'),
                    ),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 85, 143, 151),
                  )),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Verification(_controller.text)));
                  },
                  child: const Text(
                    'NEXT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
