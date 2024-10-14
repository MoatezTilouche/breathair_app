import 'package:breathair_app/pages/formforgetpassword.dart';
import 'package:breathair_app/pages/forms/nameForm.dart';
import 'package:flutter/material.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
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
                    "Forget Key! ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Request Key ",
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
