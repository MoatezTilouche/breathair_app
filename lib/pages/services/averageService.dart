import 'dart:convert';
import 'package:breathair_app/pages/services/authService.dart';
import 'package:http/http.dart' as http;

class AverageService {
  final String baseUrl = 'http://localhost:3000';

  Future<int> fetchAverage() async {
    try {
      AuthService authService = AuthService();
      String? token = await authService.getToken();
      print('Token: $token');

      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      // Fetch user profile to get email
      final userResponse = await http.get(
        Uri.parse('$baseUrl/auth/profile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('User response status: ${userResponse.statusCode}');
      print('User response: ${userResponse.body}');

      if (userResponse.statusCode != 200) {
        throw Exception('Failed to fetch user data: ${userResponse.body}');
      }

      final userData = json.decode(userResponse.body);
      String email = userData['email'] ?? '';

      if (email.isEmpty) {
        throw Exception('Email not found in user data: ${userResponse.body}');
      }

      // Fetch average cigarettes using email
      final averageResponse = await http.get(
        Uri.parse('$baseUrl/users/$email/average-cigarettes'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (averageResponse.statusCode == 200) {
        return json.decode(averageResponse.body) as int;
      } else {
        throw Exception(
            'Failed to fetch average cigarettes: ${averageResponse.body}');
      }
    } catch (e) {
      print('Error fetching average: $e');
      rethrow; // Rethrow to allow upstream handling if needed
    }
  }
}
