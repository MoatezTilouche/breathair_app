import 'package:breathair_app/pages/forms/numberCigarettesForm.dart';
import 'package:breathair_app/pages/speechBubble.dart';
import 'package:flutter/material.dart';

class SmokingTriggersForm extends StatefulWidget {
  const SmokingTriggersForm({super.key});

  @override
  State<SmokingTriggersForm> createState() => _SmokingTriggersFormState();
}

class _SmokingTriggersFormState extends State<SmokingTriggersForm> {
  List<String> _selectedTriggers = [];
  bool _isLoading = false;

  final List<String> _triggers = [
    "Loneliness",
    "Stress",
    "Studying",
    "Working",
    "Finishing a task on your day",
    "Going out with friends"
  ];

  // Toggle selection with a minimum of 1 and a maximum of 3 triggers
  void _toggleSelection(String trigger) {
    setState(() {
      if (_selectedTriggers.contains(trigger)) {
        _selectedTriggers.remove(trigger);
      } else if (_selectedTriggers.length < 3) {
        _selectedTriggers.add(trigger);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/backgroundImg.jpg", // Replace with your background image
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 70, 5, 5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const ImageIcon(
                        AssetImage("assets/robot.png"),
                        color: Color(0xFF399918),
                        size: 100,
                      ),
                      Expanded(
                        child: CustomPaint(
                          painter: SpeechBubblePainter(),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: const Text(
                              "Which of the following are the main triggers of smoking?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _triggers
                        .map((trigger) => _buildTriggerOption(trigger, context))
                        .toList(),
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: (_selectedTriggers.length >= 1 &&
                            _selectedTriggers.length <= 3)
                        ? () {
                            print("Selected Triggers: $_selectedTriggers");
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NumberCigarettesForm()));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF399918),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: const Size(300, 40),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build each selectable trigger option with a fixed width for 2 items per line
  Widget _buildTriggerOption(String trigger, BuildContext context) {
    bool isSelected = _selectedTriggers.contains(trigger);
    double width =
        MediaQuery.of(context).size.width * 0.45; // Ensuring two items per line

    return GestureDetector(
      onTap: () {
        _toggleSelection(trigger);
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? const Color(0xFF399918) : Colors.grey.shade400,
            width: 2,
          ),
        ),
        child: Text(
          trigger,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? const Color(0xFF399918) : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
