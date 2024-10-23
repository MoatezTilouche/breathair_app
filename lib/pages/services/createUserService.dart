import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:breathair_app/globals.dart' as globals;

class UserService {
  final String baseUrl = 'http://192.168.1.22:3000/users';

  // Add user function
  Future<void> addUser() async {
    // Prepare the user data from globals
    final userData = {
      'nom': globals.nom,
      'prenom': globals.prenom,
      'email': globals.email,
      'dob': globals.dob?.toIso8601String(),
      'sexe': globals.sexe,
      'datedebut': globals.datedebut?.toIso8601String(),
      'nbcigaretteinitial': globals.nbcigaretteinitial,
      'prixcig': globals.prixcig,
      'raisonsmoking': globals.raisonsmoking,
      'raisonstopsmoking': globals.raisonstopsmoking,
    };

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(userData),
      );

      if (response.statusCode == 201) {
        print('User added successfully: ${response.body}');
      } else {
        print('Failed to add user: ${response.body}');
      }
    } catch (e) {
      print('Error adding user: $e');
    }
  }
}
