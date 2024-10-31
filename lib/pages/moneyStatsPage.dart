import 'package:breathair_app/pages/appBar.dart';
import 'package:breathair_app/pages/bottomBar.dart';
import 'package:breathair_app/pages/moneyChart.dart';
import 'package:flutter/material.dart';

class StepsPage extends StatelessWidget {
  const StepsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "You saved Money is",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Circular Indicator
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: 0.75, // Adjust according to the percentage saved
                    strokeWidth: 12,
                    color: const Color(0xFF399918),
                    backgroundColor: Colors.green.withOpacity(0.2),
                  ),
                ),
                const Text(
                  '100.5 TND',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Metrics Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMetricColumn(
                    iconData: Icons.local_fire_department,
                    label: "850 kcal",
                    color: Color(0xFFFF9100)),
                _buildMetricColumn(
                    iconData: Icons.location_on,
                    label: "5 km",
                    color: Color(0xFF185519)),
                _buildMetricColumn(
                    iconData: Icons.access_time,
                    label: "120 min",
                    color: Color(0xFF87A922)),
              ],
            ),
            const SizedBox(height: 20),

            // Toggle Button Row
           
            const SizedBox(height: 20),

            // Graph Section
            const StepsGraphPage()
          ],
        ),
      ),
      bottomNavigationBar:
          DemoBottomAppBar(scaffoldKey: _scaffoldKey, selectedIndex: 5),
    );
  }

  // Helper for building metric columns
  Widget _buildMetricColumn({
    required IconData iconData,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          radius: 30,
          child: Icon(
            iconData,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Helper for toggle buttons
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
}