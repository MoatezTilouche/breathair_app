import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CigaretteBarChart extends StatefulWidget {
  const CigaretteBarChart({super.key});

  @override
  State<CigaretteBarChart> createState() => _CigaretteBarChartState();
}

class _CigaretteBarChartState extends State<CigaretteBarChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: const [
              Text(
                'Your average smoked\ncigarettes per day is',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '8',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0eaa42),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.smoking_rooms,
                    color: Color(0xFF0eaa42),
                    size: 26,
                  ),
                ],
              ),
            ],
          ),
        ),
        // Toggle buttons (Today, Weekly, Monthly)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green.shade100, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildToggleButton('Today', isSelected: false),
                _buildToggleButton('Weekly', isSelected: true),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Bar Chart
        AspectRatio(
          aspectRatio: 1.6,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 50, // Adjust the height of the bars
              barTouchData: BarTouchData(enabled: true),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      );
                      switch (value.toInt()) {
                        case 0:
                          return Text('Mon', style: style);
                        case 1:
                          return Text('Tue', style: style);
                        case 2:
                          return Text('Wed', style: style);
                        case 3:
                          return Text('Thu', style: style);
                        case 4:
                          return Text('Fri', style: style);
                        case 5:
                          return Text('Sat', style: style);
                        case 6:
                          return Text('Sun', style: style);
                        default:
                          return const Text('');
                      }
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                      toY: 40, // Taller bar for Monday
                      gradient: _barsGradient(),
                    )
                  ],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      toY: 25, // Adjust the bar height for Tuesday
                      gradient: _barsGradient(),
                    )
                  ],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                      toY: 30, // Adjust the bar height for Wednesday
                      gradient: _barsGradient(),
                    )
                  ],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(
                      toY: 45, // Adjust the bar height for Thursday
                      gradient: _barsGradient(),
                    )
                  ],
                ),
                BarChartGroupData(
                  x: 4,
                  barRods: [
                    BarChartRodData(
                      toY: 20, // Adjust the bar height for Friday
                      gradient: _barsGradient(),
                    )
                  ],
                ),
                BarChartGroupData(
                  x: 5,
                  barRods: [
                    BarChartRodData(
                      toY: 35, // Adjust the bar height for Saturday
                      gradient: _barsGradient(),
                    )
                  ],
                ),
                BarChartGroupData(
                  x: 6,
                  barRods: [
                    BarChartRodData(
                      toY: 15, 
                      gradient: _barsGradient(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButton(String title, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF0eaa42) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  LinearGradient _barsGradient() {
    return const LinearGradient(
      colors: [
        Color(0xFF0eaa42),
        Color(0xFF76d15d),
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }
}
