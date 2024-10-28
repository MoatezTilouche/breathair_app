// services/cigarette_service.dart

import 'dart:convert';
import 'package:breathair_app/pages/services/authService.dart';
import 'package:http/http.dart' as http;

class CigaretteService {
  final String baseUrl = 'http://localhost:3000';

  Future<int> fetchCigaretteCount() async {
    AuthService authService = AuthService();
    String? token = await authService.getToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    // Fetch user profile to get the email
    final profileResponse = await http.get(
      Uri.parse('$baseUrl/auth/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (profileResponse.statusCode != 200) {
      throw Exception('Failed to load profile');
    }

    var profileData = json.decode(profileResponse.body);
    String email = profileData['email'];

    // Fetch user data using email
    final userResponse = await http.get(
      Uri.parse('$baseUrl/users/$email'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (userResponse.statusCode != 200) {
      throw Exception('Failed to load user data');
    }

    var userData = json.decode(userResponse.body);
    int compteurCig = userData['compteurcig'] ?? 0;

    return compteurCig;
  }

  Future<int> fetchTimeBetweenCigarettes() async {
    AuthService authService = AuthService();
    String? token = await authService.getToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    // Fetch user profile to get the email
    final profileResponse = await http.get(
      Uri.parse('$baseUrl/auth/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (profileResponse.statusCode != 200) {
      throw Exception('Failed to load profile');
    }

    var profileData = json.decode(profileResponse.body);
    String email = profileData['email'];

    // Fetch user data to get userId
    final userResponse = await http.get(
      Uri.parse('$baseUrl/users/$email'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (userResponse.statusCode != 200) {
      throw Exception('Failed to load user data');
    }

    var userData = json.decode(userResponse.body);
    String userId = userData['_id'];

    // Fetch last challenge data using userId
    final challengeResponse = await http.get(
      Uri.parse('$baseUrl/users/$userId/last-challenge'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (challengeResponse.statusCode != 200) {
      throw Exception('Failed to load last challenge');
    }

    var challengeData = json.decode(challengeResponse.body);
    int timebtwcig = challengeData['timebtwcig'] ?? 60;

    return timebtwcig;
  }
}
