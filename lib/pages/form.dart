import 'package:breathair_app/pages/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:breathair_app/pages/ForgetPassword.dart';
import 'package:breathair_app/pages/home.dart';

class Forrm extends StatefulWidget {
  const Forrm({Key? key}) : super(key: key);

  @override
  State<Forrm> createState() => _ForrmState();
}

class _ForrmState extends State<Forrm> {
  final _formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _obscureText = true;
  bool _isLoading = false;

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
                  // Email TextFormField
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Email address",
                      labelStyle: const TextStyle(
                        color: Color(0xFF638889),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: "Enter your email",
                      hintStyle: const TextStyle(
                        color: Color(0xFF638889),
                        fontSize: 12,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFFEBF4F6)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: const Color(0xFFEBF4F6)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.mail, color: Color(0xFF00712D)),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 48),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You must fill your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  
                  // Password TextFormField
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Password",
                      labelStyle: const TextStyle(
                        color: Color(0xFF638889),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: "Enter your password",
                      hintStyle: const TextStyle(
                        color: Color(0xFF638889),
                        fontSize: 12,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFFEBF4F6)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: const Color(0xFFEBF4F6)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFF00712D)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 48),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You must fill your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
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
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),

                  // Forgot Password
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgetPass()));
                    },
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: Color(0xFF399918),
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

  Future<void> _login() async {
    if (_formGlobalKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      String email = _emailController.text;
      String password = _passwordController.text;

      try {
        var response = await _authService.loginUser(email, password);
        if (response['access_token'] != null) {
          await _authService.saveToken(response['access_token']); // Save token
          showSuccessMessage("Login successful!");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          showErrorMessage("Login failed. Please try again.");
        }
      } catch (error) {
        showErrorMessage("An error occurred. Please try again.");
      } finally {
        setState(() {
          _isLoading = false; // Stop loading indicator
        });
      }
    }
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            Colors.green, // Optional: Set background color for success message
      ),
    );
  }
}
