import 'package:breathair_app/pages/appBar.dart';
import 'package:breathair_app/pages/barchartHome.dart';
import 'package:breathair_app/pages/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String quote =
      'Take care of your body. It’s the only place you have to live.';
  String author = 'Jim Rohn';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Timer variable
  int nextCigaretteTime = 30; // Time in minutes until the next cigarette
  String timerText = 'Next cigarette in 30 min';

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
                          'TUES 11 JUL',
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
                            "'Every Failure is a lesson'",
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
                                "Moatez Tilouche",
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
                                const Text(
                                  '8',
                                  style: TextStyle(
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
                                TimerCountdown(
                                  format: CountDownTimerFormat.hoursMinutes,
                                  endTime: DateTime.now().add(
                                    Duration(
                                      minutes:
                                          nextCigaretteTime, // Countdown time
                                    ),
                                  ),
                                  onEnd: () {
                                    print("Timer finished");
                                  },
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Next Cigarette Timer',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Timer updated every minute',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 24), // Add some space before the chart

                    // Bar Chart with fixed height
                    SizedBox(
                      height: 500, // Set a fixed height for the bar chart
                      child: CigaretteBarChart(), // Add your bar chart here
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
