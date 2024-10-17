// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // Import for TextInputFormatter
// import 'package:breathair_app/pages/forms/Start.dart';
// import 'package:breathair_app/pages/speechBubble.dart';

// class PriceOfCigaretteForm extends StatefulWidget {
//   const PriceOfCigaretteForm({super.key});

//   @override
//   State<PriceOfCigaretteForm> createState() => _PriceOfCigaretteFormState();
// }

// class _PriceOfCigaretteFormState extends State<PriceOfCigaretteForm> {
//   final TextEditingController _priceController = TextEditingController();
//   bool _isLoading = false;
//   bool _isFieldSelected = false;

//   final FocusNode _focusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     _focusNode.addListener(() {
//       setState(() {
//         _isFieldSelected = _focusNode.hasFocus;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     _priceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             child: Image.asset(
//               "assets/backgroundImg.jpg",
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(5, 70, 0, 5),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       const ImageIcon(
//                         AssetImage("assets/robot.png"),
//                         color: Color(0xFF399918),
//                         size: 100,
//                       ),
//                       Expanded(
//                         child: CustomPaint(
//                           painter: SpeechBubblePainter(),
//                           child: Container(
//                             padding: const EdgeInsets.all(20),
//                             child: const Text(
//                               "How much does a pack of cigarettes cost in TND?",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.center,
//                               softWrap: true,
//                               overflow: TextOverflow.visible,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 50),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: TextField(
//                       controller: _priceController,
//                       keyboardType: TextInputType.number,
//                       inputFormatters: <TextInputFormatter>[
//                         FilteringTextInputFormatter.digitsOnly // Allow only digits
//                       ],
//                       focusNode: _focusNode,
//                       decoration: InputDecoration(
//                         labelText: 'Enter price',
//                         labelStyle: TextStyle(
//                           color: _isFieldSelected ? Colors.green : Colors.grey,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w400,
//                         ),
//                         suffix: const Text(
//                           'TND',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(
//                             color: Color(0xFF399918),
//                           ),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 70),
//                   ElevatedButton(
//                     onPressed: () {
//                       FocusScope.of(context).unfocus(); // Close the keyboard
//                       if (_priceController.text.isNotEmpty) {
//                         print("Entered Price: ${_priceController.text} TND");
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const Start(),
//                           ),
//                         );
//                       } else {
//                         // Show a Snackbar or some form of alert to indicate that input is required
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Please enter a price'),
//                           ),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF399918),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       minimumSize: const Size(300, 40),
//                     ),
//                     child: _isLoading
//                         ? const CircularProgressIndicator(
//                             valueColor:
//                                 AlwaysStoppedAnimation<Color>(Colors.white),
//                           )
//                         : const Text(
//                             'Continue',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 15,
//                             ),
//                           ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter
import 'package:breathair_app/pages/forms/Start.dart';
import 'package:breathair_app/pages/speechBubble.dart';
import 'package:breathair_app/globals.dart'
    as globals; // Import your globals file
import 'package:http/http.dart' as http; // Import http package
import 'dart:convert'; // For json encoding

class PriceOfCigaretteForm extends StatefulWidget {
  const PriceOfCigaretteForm({super.key});

  @override
  State<PriceOfCigaretteForm> createState() => _PriceOfCigaretteFormState();
}

class _PriceOfCigaretteFormState extends State<PriceOfCigaretteForm> {
  final TextEditingController _priceController = TextEditingController();
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

  Future<void> _addUser() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    // Prepare the user data
    final userData = {
      'nom': globals.nom,
      'prenom': globals.prenom,
      'email': globals.email,
      'dob': globals.dob?.toIso8601String(), // Convert DateTime to string
      'sexe': globals.sexe,
      'datedebut':
          globals.datedebut?.toIso8601String(), // Convert DateTime to string
      'nbcigaretteinitial': globals.nbcigaretteinitial,
      'prixcig': globals.prixcig,
      'raisonsmoking': globals.raisonsmoking,
      'raisonstopsmoking': globals.raisonstopsmoking,
    };

    // Make the POST request
    try {
      final response = await http.post(
        Uri.parse('http://172.16.50.97:3000/users'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(userData),
      );

      if (response.statusCode == 201) {
        // Successfully added the user
        print('User added: ${response.body}');
      } else {
        // Handle error response
        print('Failed to add user: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
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
                        FilteringTextInputFormatter
                            .digitsOnly // Allow only digits
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
                    onPressed: () {
                      FocusScope.of(context).unfocus(); // Close the keyboard
                      if (_priceController.text.isNotEmpty) {
                        // Parse the price and save it to the global variable
                        globals.prixcig =
                            double.tryParse(_priceController.text) ?? 0.0;
                        print("Entered Price: ${globals.prixcig} TND");

                        // Call the function to add the user
                        _addUser().then((_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Start(),
                            ),
                          );
                        });
                      } else {
                        // Show a Snackbar or some form of alert to indicate that input is required
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a price'),
                          ),
                        );
                      }
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
}
