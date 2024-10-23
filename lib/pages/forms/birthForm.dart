import 'package:breathair_app/pages/forms/raisonForm.dart';
import 'package:breathair_app/pages/speechBubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:breathair_app/globals.dart' as globals; 


class YearOfBirthForm extends StatefulWidget {
  const YearOfBirthForm({super.key});

  @override
  State<YearOfBirthForm> createState() => _YearOfBirthFormState();
}

class _YearOfBirthFormState extends State<YearOfBirthForm> {
  DateTime? _selectedDate; // Store the selected date
  bool _isLoading = false;

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked; // Update the selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Close the keyboard when tapping outside
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/backgroundImg.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 70, 5, 0),
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
                        CustomPaint(
                          painter: SpeechBubblePainter(),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: const Text(
                              "What's your year of birth?",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),

                    // Date Picker Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextButton(
                        onPressed: () => _selectYear(context),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _selectedDate == null
                              ? 'Select your year of birth'
                              : 'Selected Year: ${DateFormat('yyyy').format(_selectedDate!)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 70),

                 ElevatedButton(
  onPressed: () {
    FocusScope.of(context).unfocus(); 
    setState(() {
      _isLoading = true;
    });

    // Perform your validation here before navigating
    if (_selectedDate != null) {
      // Assign the selected date to the global variable
      globals.dob = _selectedDate; // Save the selected date

      // Print to confirm the assignment
      print("Selected year of birth: ${globals.dob != null ? DateFormat('yyyy').format(globals.dob!) : 'Not selected'}");

      // Navigate to the RaisonForm
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RaisonForm()),
      );
    } else {
      // Show a message if no year is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your year of birth')),
      );
    }

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF399918),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    minimumSize: const Size(300, 40),
  ),
  child: _isLoading
      ? const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
      ),
    );
  }
}
