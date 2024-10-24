import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:breathair_app/pages/home.dart';
import 'package:breathair_app/pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    // Simulate a delay for the splash screen
    Future.delayed(const Duration(seconds: 3), () {
      checkIsAuth();
    });
  }

  Future<void> checkIsAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isAuth = prefs.getBool("isAuth");
    var token = await _storage.read(key: "access_token");

    // Check if both isAuth is true and the token is not null
    if (isAuth == true && token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 238, 240),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo2.png', // Replace with your image asset
              height: 200.0,
              width: 200.0,
            ),
            const SizedBox(height: 20.0),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Loading...",
              style: TextStyle(
                color: Colors.green,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
