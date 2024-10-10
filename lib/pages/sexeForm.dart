import 'package:breathair_app/pages/birthForm.dart';
import 'package:breathair_app/pages/speechBubble.dart';
import 'package:flutter/material.dart';

class SexeForm extends StatefulWidget {
  const SexeForm({super.key});

  @override
  State<SexeForm> createState() => _SexeFormState();
}

class _SexeFormState extends State<SexeForm> {
  String _selectedGender = ''; 
  bool _isLoading = false;

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
              "assets/backgroundImg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
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
                          padding: const EdgeInsets.all(20),
                          child: const Text(
                            "You identify yourself as:",
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
                  const SizedBox(height: 50),

                  // Gender selection options styled like input fields
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        _buildGenderOption("Male"),
                        const SizedBox(height: 10),
                        _buildGenderOption("Female"),
                        const SizedBox(height: 10),
                        _buildGenderOption("Other"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 70),

                 
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedGender.isNotEmpty) {
                        print("Selected gender: $_selectedGender");
                      }
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context)=> const YearOfBirthForm()   ));
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

  Widget _buildGenderOption(String gender) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _selectedGender == gender
                ? const Color(0xFF399918) 
                : Colors.grey, 
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            gender,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _selectedGender == gender
                  ? const Color(0xFF399918) 
                  : Colors.black, 
            ),
          ),
        ),
      ),
    );
  }
}
