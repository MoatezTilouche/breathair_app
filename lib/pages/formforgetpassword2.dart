
import 'package:breathair_app/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Forrm extends StatefulWidget {
  const Forrm({Key? key}) : super(key: key);

  @override
  State<Forrm> createState() => _ForrmState();
}

class _ForrmState extends State<Forrm> {
  final _formGlobalKey = GlobalKey<FormState>();

  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  // Function to handle password reset API call
  Future<void> _resetPassword() async {
    if (_formGlobalKey.currentState!.validate()) {
      _formGlobalKey.currentState!.save();

      // Prepare API request
      final url = Uri.parse('http://localhost:3000/auth/reset-password');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'token': _tokenController.text, // Sending the token
        'newPassword': _passwordController.text, // Sending the new password
      });

      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 201) {
          // Handle success
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset successful')),
          );

          // Navigate back to the login page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            ),
          ); // Assuming '/login' is the route name for your login page
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to reset password: ${response.body}')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Form(
              key: _formGlobalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _tokenController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Token",
                      labelStyle: const TextStyle(
                          color: Color(0xFF638889),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      hintText: "Enter your token",
                      hintStyle: const TextStyle(
                          color: Color(0xFF638889), fontSize: 12),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFFEBF4F6)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: const Color(0xFFEBF4F6)),
                      ),
                      prefixIcon:
                          const Icon(Icons.vpn_key, color: Color(0xFF00712D)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 48),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You must fill your token';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "New Password",
                      labelStyle: const TextStyle(
                          color: Color(0xFF638889),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      hintText: "Enter your new password",
                      hintStyle: const TextStyle(
                          color: Color(0xFF638889), fontSize: 12),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFFEBF4F6)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: const Color(0xFFEBF4F6)),
                      ),
                      prefixIcon:
                          const Icon(Icons.lock, color: Color(0xFF00712D)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 48),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You must fill your new password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _resetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF399918),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: const Size(450, 40),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            'Reset password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
