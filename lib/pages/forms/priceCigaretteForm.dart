import 'package:breathair_app/pages/services/createUserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:breathair_app/pages/forms/Start.dart';
import 'package:breathair_app/pages/speechBubble.dart';
import 'package:breathair_app/globals.dart' as globals;

class PriceOfCigaretteForm extends StatefulWidget {
  const PriceOfCigaretteForm({super.key});

  @override
  State<PriceOfCigaretteForm> createState() => _PriceOfCigaretteFormState();
}

class _PriceOfCigaretteFormState extends State<PriceOfCigaretteForm> {
  final TextEditingController _priceController = TextEditingController();
  final UserService _userService = UserService(); // Instantiate the service
  bool _isLoading = false;
  bool _isFieldSelected = false;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFieldSelected = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    if (_priceController.text.isNotEmpty) {
      globals.prixcig = double.tryParse(_priceController.text) ?? 0.0;
      print("Entered Price: ${globals.prixcig} TND");

      // Call the service to add the user
      await _userService.addUser();

      setState(() {
        _isLoading = false; // Stop loading
      });

      // Navigate to the next screen after user is added
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Start(),
        ),
      );
    } else {
      setState(() {
        _isLoading = false; // Stop loading if price is not entered
      });

      // Show a Snackbar to inform the user to input a price
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a price'),
        ),
      );
    }
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
              "assets/backgroundImg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 70, 0, 5),
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
                              "How much does a pack of cigarettes cost in TND?",
                              style: TextStyle(
                                fontSize: 12,
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
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly // Only allow digits
                      ],
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        labelText: 'Enter price',
                        labelStyle: TextStyle(
                          color: _isFieldSelected ? Colors.green : Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        suffix: const Text(
                          'TND',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF399918),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm, // Use submit form
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
}
