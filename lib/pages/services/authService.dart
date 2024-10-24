import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'http://localhost:3000/auth';
  final _storage = const FlutterSecureStorage();

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

      // Save the token securely using FlutterSecureStorage
      await saveToken(token);

      // Save the isAuth flag as true
      await saveAuthFlag(true);

      return data;
    } else {
      throw Exception('Failed to log in');
    }
  }

  // Save token securely using FlutterSecureStorage
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  // Retrieve token from secure storage
  Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  // Save isAuth flag in SharedPreferences
  Future<void> saveAuthFlag(bool isAuth) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuth', isAuth);
  }

  // Logout (clear token and auth flag)
  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isAuth');
  }
}
