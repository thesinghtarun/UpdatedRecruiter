import 'package:flutter/material.dart';
import 'package:recruiter/screens/forgot_password/updated.dart';

class Credentials extends StatefulWidget {
  const Credentials({super.key});

  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  bool _passwordVisible = false;

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
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset("assets/images/credentials.png"),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "NEW",
            style: TextStyle(fontFamily: "Merriweather", fontSize: 25),
          ),
          Text(
            "CREDENTIALS",
            style: TextStyle(fontFamily: "Merriweather", fontSize: 25),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Your identity has been verified! \n      Set your New password",
            style: TextStyle(color: Colors.black87),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 27, right: 27, bottom: 10, top: 10),
            child: TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                hintText: "New Password*",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.lock_outline_rounded),
                suffixIcon: Icon(Icons.password),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
              cursorColor: Colors.grey,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 27,
              right: 27,
              bottom: 10,
            ),
            child: TextField(
              controller: _confirmpasswordcontroller,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                hintText: "Confirm Password*",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.lock_outline_rounded),
                suffixIcon: Icon(Icons.password),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
              cursorColor: Colors.grey,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.only(left: 27, right: 27),
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Color.fromARGB(255, 85, 143, 151),
              )),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Updated()));
              },
              child: Text(
                'NEXT',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
