import 'package:breathair_app/pages/services/averageService.dart';
import 'package:breathair_app/pages/services/chartService.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CigaretteBarChart extends StatefulWidget {
  const CigaretteBarChart({super.key});

  @override
  State<CigaretteBarChart> createState() => _CigaretteBarChartState();
}

class _CigaretteBarChartState extends State<CigaretteBarChart> {
  late Future<List<Map<String, double>>> _challengeData;
  int? averageCigarettes; // Variable to hold the average
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _challengeData = ChartService().fetchChallengeData();
    _fetchAverageCigarettes();
  }

  Future<void> _fetchAverageCigarettes() async {
    AverageService averageService = AverageService();
    try {
      int average = await averageService.fetchAverage();
      setState(() {
        averageCigarettes = average; // Update the average
        isLoading = false; // Stop loading
      });
    } catch (e) {
      print('Error fetching average: $e');
      setState(() {
        isLoading = false; // Stop loading even on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const Text(
                'Your average smoked\ncigarettes per day is',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? const CircularProgressIndicator() // Show loading indicator while fetching
                      : Text(
                          averageCigarettes?.toString() ?? '0', // Display the average or '0' if null
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0eaa42),
                          ),
                        ),
                  const SizedBox(width: 5),
                  const Icon(
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
        FutureBuilder<List<Map<String, double>>>(
          future: _challengeData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            }

            List<Map<String, double>> challengeData = snapshot.data!;
            return AspectRatio(
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
                  barGroups: List.generate(challengeData.length, (index) {
                    return BarChartGroupData(
                      x: challengeData[index]['x']!.toInt(),
                      barRods: [
                        BarChartRodData(
                          toY: challengeData[index]['y']!,
                          gradient: _barsGradient(),
                        )
                      ],
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildToggleButton(String title, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0eaa42) : Colors.white,
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


// import 'package:breathair_app/pages/services/averageService.dart'; // Import AverageService
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class CigaretteBarChart extends StatefulWidget {
//   const CigaretteBarChart({super.key});

//   @override
//   State<CigaretteBarChart> createState() => _CigaretteBarChartState();
// }

// class _CigaretteBarChartState extends State<CigaretteBarChart> {
//   int? averageCigarettes; // Variable to hold the average
//   bool isLoading = true; // To handle loading state

//   @override
//   void initState() {
//     super.initState();
//     _fetchAverageCigarettes();
//   }

//   Future<void> _fetchAverageCigarettes() async {
//     AverageService averageService = AverageService();
//     try {
//       int average = await averageService.fetchAverage();
//       setState(() {
//         averageCigarettes = average; // Update the average
//         isLoading = false; // Stop loading
//       });
//     } catch (e) {
//       print('Error fetching average: $e');
//       setState(() {
//         isLoading = false; // Stop loading even on error
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           child: Column(
//             children: [
//               const Text(
//                 'Your average smoked\ncigarettes per day is',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   isLoading
//                       ? const CircularProgressIndicator() // Show loading indicator while fetching
//                       : Text(
//                           averageCigarettes?.toString() ?? '0', // Display the average or '0' if null
//                           style: const TextStyle(
//                             fontSize: 26,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF0eaa42),
//                           ),
//                         ),
//                   const SizedBox(width: 5),
//                   const Icon(
//                     Icons.smoking_rooms,
//                     color: Color(0xFF0eaa42),
//                     size: 26,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         // Toggle buttons (Today, Weekly, Monthly)
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.green.shade100, width: 2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildToggleButton('Today', isSelected: false),
//                 _buildToggleButton('Weekly', isSelected: true),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         // Bar Chart
//         AspectRatio(
//           aspectRatio: 1.6,
//           child: BarChart(
//             BarChartData(
//               alignment: BarChartAlignment.spaceAround,
//               maxY: 50, // Adjust the height of the bars
//               barTouchData: BarTouchData(enabled: true),
//               titlesData: FlTitlesData(
//                 show: true,
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 30,
//                     getTitlesWidget: (value, meta) {
//                       const style = TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       );
//                       switch (value.toInt()) {
//                         case 0:
//                           return Text('Mon', style: style);
//                         case 1:
//                           return Text('Tue', style: style);
//                         case 2:
//                           return Text('Wed', style: style);
//                         case 3:
//                           return Text('Thu', style: style);
//                         case 4:
//                           return Text('Fri', style: style);
//                         case 5:
//                           return Text('Sat', style: style);
//                         case 6:
//                           return Text('Sun', style: style);
//                         default:
//                           return const Text('');
//                       }
//                     },
//                   ),
//                 ),
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: false,
//                   ),
//                 ),
//                 rightTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: false,
//                   ),
//                 ),
//                 topTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: false,
//                   ),
//                 ),
//               ),
//               borderData: FlBorderData(
//                 show: false,
//               ),
//               barGroups: [
//                 // Example bar data, replace with dynamic data if needed
//                 BarChartGroupData(
//                   x: 0,
//                   barRods: [
//                     BarChartRodData(
//                       toY: averageCigarettes?.toDouble() ?? 0, // Use the average here
//                       gradient: _barsGradient(),
//                     )
//                   ],
//                 ),
//                 // Add other bar data for different days...
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildToggleButton(String title, {required bool isSelected}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       decoration: BoxDecoration(
//         color: isSelected ? const Color(0xFF0eaa42) : Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         title,
//         style: TextStyle(
//           color: isSelected ? Colors.white : Colors.green,
//           fontWeight: FontWeight.bold,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }

//   LinearGradient _barsGradient() {
//     return const LinearGradient(
//       colors: [
//         Color(0xFF0eaa42),
//         Color(0xFF76d15d),
//       ],
//       begin: Alignment.bottomCenter,
//       end: Alignment.topCenter,
//     );
//   }
// }

