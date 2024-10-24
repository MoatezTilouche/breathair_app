import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://localhost:3000/auth';

  // Login function
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Login successful
      final data = jsonDecode(response.body);
      final token = data['access_token'];

      // Display the token in the console
      print('Token: $token');

      // Save the token in SharedPreferences
      await saveToken(token);

      return data;
    } else {
      throw Exception('Failed to log in');
    }
  }

  // Save token in local storage (SharedPreferences)
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  // Retrieve token from local storage
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Logout (clear token)
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }
}
