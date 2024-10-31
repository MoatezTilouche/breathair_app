import 'dart:convert';
import 'package:breathair_app/pages/services/authService.dart';
import 'package:http/http.dart' as http;

class ChartService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Map<String, double>>> fetchChallengeData() async {
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
        throw Exception('Failed to fetch user profile: ${userResponse.body}');
      }

      final userData = json.decode(userResponse.body);
      String email = userData['email'] ?? '';

      if (email.isEmpty) {
        throw Exception('Email not found in user data: ${userResponse.body}');
      }

      // Fetch Chart cigarettes using email
      final chartResponse = await http.get(
        Uri.parse('$baseUrl/users/$email/challenges'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('Chart response status: ${chartResponse.statusCode}');
      print('Chart response: ${chartResponse.body}');

      if (chartResponse.statusCode != 200) {
        throw Exception(
            'Failed to fetch Chart cigarettes: ${chartResponse.body}');
      }

      final List<Map<String, dynamic>> challenges =
          List<Map<String, dynamic>>.from(json.decode(chartResponse.body));

      // Create a list of maps with `x` and `y` values
      List<Map<String, double>> challengeData = challenges.map((challenge) {
        final dateStr = challenge['dateactuel'];
        final double nbcigsmoked = (challenge['nbexpeccig'] ?? 0).toDouble();

        // Check if dateStr is valid before parsing
        DateTime dateactuel;
        try {
          dateactuel = DateTime.parse(dateStr);
        } catch (e) {
          throw Exception('Invalid date format: $dateStr');
        }

        final int weekday = dateactuel.weekday - 1; // Monday=0, ..., Sunday=6

        return {
          'x': weekday.toDouble(),
          'y': nbcigsmoked,
        };
      }).toList();

      return challengeData;
    } catch (e) {
      print('Error fetching Chart: $e');
      rethrow;
    }
  }
}
