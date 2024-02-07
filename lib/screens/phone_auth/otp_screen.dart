import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
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
            Icons.close,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 0,
          ),
          const Text(
            "CO",
            style: TextStyle(fontSize: 80, fontWeight: FontWeight.w900),
          ),
          const Text(
            "DE",
            style: TextStyle(fontSize: 80, fontWeight: FontWeight.w900),
          ),
          const Text(
            "VERIFICATION",
            style: TextStyle(fontFamily: "Merriweather", fontSize: 20),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Enter one time password sent on ",
            style: TextStyle(color: Colors.black87),
          ),
          const Center(
            child: Text(
              '+91 phoneNumber',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ),
          TextField(
            controller: _otpController,
            decoration: const InputDecoration(
              hintText: "Otp",
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
          Container(
            margin: const EdgeInsets.only(left: 27, right: 27),
            width: double.infinity,
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Color.fromARGB(255, 85, 143, 151),
              )),
              onPressed: () => print("object"),
              child: const Text(
                'NEXT',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
