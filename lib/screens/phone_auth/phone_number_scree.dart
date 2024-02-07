import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
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
                "assets/images/welcomeScreen.png",
                height: 150,
              )),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Recruiter",
                style: TextStyle(
                    color: Color.fromARGB(255, 85, 143, 151),
                    fontSize: 60,
                    fontFamily: "GreatVibes-Regular"),
              ),
              const Text(
                "Login",
                style: TextStyle(fontSize: 28, fontFamily: "Merriweather"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your Phone Number",
                style: TextStyle(color: Colors.black87),
              ),
              const Text(
                "You will get an Otp on it",
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
                  controller: _phoneNumberController,
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
                  onPressed: () => Navigator.pushNamed(context, '/OtpScreen'),
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
