import 'dart:convert'; // For json decoding
import 'dart:math'; // For random selection
import 'package:breathair_app/pages/appBar.dart';
import 'package:breathair_app/pages/barchartHome.dart';
import 'package:breathair_app/pages/bottomBar.dart';
import 'package:breathair_app/pages/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting
import 'package:http/http.dart' as http; // Add this import for HTTP requests
import 'package:shared_preferences/shared_preferences.dart'; // Import for SharedPreferences

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String quote = '';
  String author = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Timer variable
  int timebtwcig = 0; // Time in minutes until the next cigarette
  int compteurCig = 0; // Variable to store the number of cigarettes

  @override
  void initState() {
    super.initState();
    fetchRandomQuote(); // Fetch quote when the widget is initialized
    fetchCigaretteCount(); // Fetch cigarette count when the widget is initialized
  }

  Future<void> fetchRandomQuote() async {
    final response = await http.get(Uri.parse('http://localhost:3000/quotes'));

    if (response.statusCode == 200) {
      List quotes = json.decode(response.body);
      if (quotes.isNotEmpty) {
        final random = Random();
        final randomQuote = quotes[random.nextInt(quotes.length)];

        setState(() {
          quote = randomQuote['text'];
          author = randomQuote['sujet'];
        });
      }
    } else {
      throw Exception('Failed to load quotes');
    }
  }

  Future<void> fetchCigaretteCount() async {
    AuthService authService = AuthService();
    String? token = await authService.getToken();

    if (token != null) {
      // Fetch user profile to get the email
      final profileResponse = await http.get(
        Uri.parse('http://localhost:3000/auth/profile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (profileResponse.statusCode == 200) {
        var profileData = json.decode(profileResponse.body);
        String email = profileData['email']; // Get email from profile

        final userResponse = await http.get(
          Uri.parse('http://localhost:3000/users/$email'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (userResponse.statusCode == 200) {
          var userData = json.decode(userResponse.body);
          String userId = userData['_id']; // Get user ID from user data
          setState(() {
            compteurCig = userData['compteurcig'] ?? 0; // Set cigarette count
          });

          final challengeResponse = await http.get(
            Uri.parse('http://localhost:3000/users/$userId/last-challenge'),
            headers: {
              'Authorization': 'Bearer $token',
            },
          );

          if (challengeResponse.statusCode == 200) {
            var challengeData = json.decode(challengeResponse.body);
            setState(() {
              timebtwcig = challengeData['timebtwcig'] ?? 60;
            });
          } else {
            throw Exception('Failed to load last challenge');
          }
        } else {
          throw Exception('Failed to load user data');
        }
      } else {
        throw Exception('Failed to load profile');
      }
    } else {
      throw Exception('Token not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsive padding
    final padding = MediaQuery.of(context).size.width * 0.04;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFf6f6f6),
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Using Flexible to manage vertical space
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Date Row
                    Row(
                      children: [
                        const Icon(Icons.wb_sunny_outlined, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('EEE dd MMM').format(
                              DateTime.now()), // Format the current date
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Overview',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // Quote Container
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Quote Of The Day',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.format_quote,
                                  color: Colors.green, size: 30),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            quote.isNotEmpty
                                ? "'$quote'"
                                : "Loading quote...", // Display the fetched quote
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.person, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                author,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Highlights section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Highlights',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'View more',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Highlights cards
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Number of Cigarettes Card
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0eaa42),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                const Icon(Icons.smoking_rooms,
                                    size: 40, color: Colors.white),
                                const SizedBox(height: 8),
                                const Text(
                                  'Number of Cigarettes',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '$compteurCig',
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'updated 15 min ago',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFE763E),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                const Icon(Icons.access_time,
                                    size: 30, color: Colors.white),
                                const SizedBox(height: 8),
                                timebtwcig > 0
                                    ? TimerCountdown(
                                        format:
                                            CountDownTimerFormat.hoursMinutes,
                                        endTime: DateTime.now().add(
                                          Duration(minutes: timebtwcig),
                                        ),
                                        onEnd: () {
                                          print("Timer finished");
                                        },
                                      )
                                    : const Text(
                                        'Loading time...',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70),
                                      ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Next Cigarette ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Time remaining',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Statistics',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const CigaretteBarChart(), // Ensure this widget is implemented
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          DemoBottomAppBar(scaffoldKey: _scaffoldKey, selectedIndex: 0),
    );
  }
}
