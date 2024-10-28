import 'dart:convert';
import 'dart:math';
import 'package:breathair_app/pages/appBar.dart';
import 'package:breathair_app/pages/barchartHome.dart';
import 'package:breathair_app/pages/blogCard.dart';
import 'package:breathair_app/pages/bottomBar.dart';
import 'package:breathair_app/pages/services/authService.dart';
import 'package:breathair_app/pages/services/statsService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CigaretteService _cigaretteService = CigaretteService();

  String quote = '';
  String author = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int timebtwcig = 0;
  int compteurCig = 0;

  @override
  void initState() {
    super.initState();
    fetchRandomQuote();
    fetchCigaretteCount();
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
    try {
      int fetchedCompteurCig = await _cigaretteService.fetchCigaretteCount();
      int fetchedTimeBtwCig =
          await _cigaretteService.fetchTimeBetweenCigarettes();

      setState(() {
        compteurCig = fetchedCompteurCig;
        timebtwcig = fetchedTimeBtwCig;
      });
    } catch (error) {
      print('Error fetching cigarette data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          DateFormat('EEE dd MMM').format(DateTime.now()),
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
                            quote.isNotEmpty ? "'$quote'" : "Loading quote...",
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
                    const SizedBox(height: 26),

                    // Highlights cards
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                        endTime: DateTime.now()
                                            .add(Duration(minutes: timebtwcig)),
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
                    const SizedBox(height: 26),
                    const Text(
                      'Statistics',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    // Bar chart with fixed height to avoid overflow
                    CigaretteBarChart(),

                    const SizedBox(height: 16),
                    const Text(
                      'Blogs',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    // Horizontally scrollable BlogCard section
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          BlogCard(
                            category: 'Nutrition',
                            title:
                                'Smoking has an effect in harming your lungs',
                            votes: 78,
                            imageUrl:
                                'https://images.unsplash.com/photo-1593974123009-e87a2188ae12?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c21va2luZyUyMGtpbGxzfGVufDB8fDB8fHww',
                          ),
                          const SizedBox(width: 12),
                          BlogCard(
                            category: 'Lifestyle',
                            title:
                                'The secrets of maximizing your productivity',
                            votes: 54,
                            imageUrl:
                                'https://images.unsplash.com/photo-1566159549726-435f258cf4e7?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fHw%3D',
                          ),
                        ],
                      ),
                    ),
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
