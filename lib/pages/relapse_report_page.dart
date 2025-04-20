import 'package:breathair_app/pages/home.dart';
import 'package:flutter/material.dart';

class RelapseReportDialog extends StatelessWidget {
  final Map<String, dynamic> analysis;

  const RelapseReportDialog({Key? key, required this.analysis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recommendations = analysis['recommendations'] ?? {};
    return AlertDialog(
      title: Text("Rapport de rechute"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Conseils immédiats:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildRecommendationList(recommendations['immediate']),
            SizedBox(height: 16),
            Text(
              'Alternatives:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildRecommendationList(recommendations['alternatives']),
            SizedBox(height: 16),
            Text(
              'Long terme:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildRecommendationList(recommendations['longTerm']),
            SizedBox(height: 16),
            Text(
              'Gestion du stress:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildRecommendationList(recommendations['stressManagement']),
            SizedBox(height: 16),
            Text(
              'Environnement:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildRecommendationList(recommendations['environment']),
          ],
        ),
      ),
      actions: [
        TextButton(
  onPressed: () {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Home()),
    );
  },
  child: Text('Fermer'),
)

      ],
    );
  }

  Widget _buildRecommendationList(List<dynamic> recommendations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: recommendations.map<Widget>((rec) => Text('- $rec')).toList(),
    );
  }
}
