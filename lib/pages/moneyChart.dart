import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StepsGraphPage extends StatefulWidget {
  const StepsGraphPage({Key? key}) : super(key: key);

  @override
  State<StepsGraphPage> createState() => _StepsGraphPageState();
}

class _StepsGraphPageState extends State<StepsGraphPage> {
  String selectedTab = "Weekly";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, // Adjusted width
        height: 250, // Set a fixed height for the widget
        child: Column(
          mainAxisSize: MainAxisSize.min, // Allow Column to take only needed space
          children: [
            // Tab Selector
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: const Color(0xFF53dd22),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabSelector("Today"),
                  _buildTabSelector("Weekly", isSelected: true),
                  _buildTabSelector("Monthly"),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Line Chart
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF53dd22),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(8.0), // Reduced padding
              child: SizedBox(
                height: 150, // Fixed height for the chart itself
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                            return Text(
                              days[value.toInt()],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10, // Smaller font size
                              ),
                            );
                          },
                          interval: 1,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false), // Hide y-axis numbers
                      ),
                       rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false), // Hide y-axis numbers
                      ),
                       topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false), // Hide y-axis numbers
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        spots: const [
                          FlSpot(0, 5.0), // Monday: 5.0 TND
                          FlSpot(1, 7.5), // Tuesday: 7.5 TND
                          FlSpot(2, 6.0), // Wednesday: 6.0 TND
                          FlSpot(3, 8.0), // Thursday: 8.0 TND
                          FlSpot(4, 5.5), // Friday: 5.5 TND
                          FlSpot(5, 10.0), // Saturday: 10.0 TND
                          FlSpot(6, 4.5), // Sunday: 4.5 TND
                        ],
                        dotData: FlDotData(show: true),
                        color: Colors.white,
                        barWidth: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for tab selection
  Widget _buildTabSelector(String text, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFF53dd22),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isSelected ? const Color(0xFF53dd22) : Colors.white,
          ),
        ),
      ),
    );
  }
}
