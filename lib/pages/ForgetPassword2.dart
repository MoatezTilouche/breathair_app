import 'package:breathair_app/pages/formforgetpassword2.dart';
import 'package:breathair_app/pages/forms/nameForm.dart';
import 'package:flutter/material.dart';

class ForgetPass1 extends StatefulWidget {
  const ForgetPass1({super.key});

  @override
  State<ForgetPass1> createState() => _ForgetPass1State();
}

class _ForgetPass1State extends State<ForgetPass1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Center(
                    child: Image.asset('assets/logo2.png', height: 85),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Reset Password! ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "New password ",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Forrm(),
                  const SizedBox(height: 15),
                  const SizedBox(height: 15),
                  const SizedBox(
                    height: 90,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NameForm()));
                    },
                    child: const Text(
                      "Don't have account? Sign Up",
                      style: TextStyle(
                        color: const Color(0xFF399918),
                        decoration: TextDecoration.underline,
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
}
