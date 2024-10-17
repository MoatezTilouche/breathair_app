// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:breathair_app/pages/form.dart';
import 'package:breathair_app/pages/forms/nameForm.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                    child: Image.asset('assets/logo2.png', height: 185),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Welcome Back! ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Login to continue ",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Forrm(),
                  const SizedBox(height: 15),
                  const Text("OR LOG IN WITH",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.facebook,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.apple,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.snapchat_rounded,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
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
