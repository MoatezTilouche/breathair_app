// import 'package:breathair_app/pages/forms/birthForm.dart';
// import 'package:breathair_app/pages/forms/numberCigarettesForm.dart';
// import 'package:breathair_app/pages/forms/smokingTriggersForm.dart';
// import 'package:breathair_app/pages/speechBubble.dart';
// import 'package:flutter/material.dart';

// class RaisonForm extends StatefulWidget {
//   const RaisonForm({super.key});

//   @override
//   State<RaisonForm> createState() => _RaisonFormState();
// }

// class _RaisonFormState extends State<RaisonForm> {
//   String _selectedReason = '';
//   bool _isLoading = false;

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
//             padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
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
//                               "Which of the following is the main reason you want to change?",
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
//                     child: Column(
//                       children: [
//                         _buildReasonOption("My health"),
//                         const SizedBox(height: 10),
//                         _buildReasonOption("My family"),
//                         const SizedBox(height: 10),
//                         _buildReasonOption("Save Money"),
//                         const SizedBox(height: 10),
//                         _buildReasonOption("To be free"),
//                         const SizedBox(height: 10),
//                         _buildReasonOption("To have a child"),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 70),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_selectedReason.isNotEmpty) {
//                         print("Selected Reason: $_selectedReason");
//                       }
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const SmokingTriggersForm()));
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

//   Widget _buildReasonOption(String reason) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedReason = reason;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: _selectedReason == reason
//                 ? const Color(0xFF399918)
//                 : Colors.grey,
//             width: 2,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             reason,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: _selectedReason == reason
//                   ? const Color(0xFF399918)
//                   : Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:breathair_app/pages/forms/birthForm.dart';
import 'package:breathair_app/pages/forms/numberCigarettesForm.dart';
import 'package:breathair_app/pages/forms/smokingTriggersForm.dart';
import 'package:breathair_app/pages/speechBubble.dart';
import 'package:flutter/material.dart';
import 'package:breathair_app/globals.dart'
    as globals; // Import the global variables

class RaisonForm extends StatefulWidget {
  const RaisonForm({super.key});

  @override
  State<RaisonForm> createState() => _RaisonFormState();
}

class _RaisonFormState extends State<RaisonForm> {
  List<String> _selectedReasons = []; // Change to List
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
                      Expanded(
                        child: CustomPaint(
                          painter: SpeechBubblePainter(),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: const Text(
                              "Which of the following is the main reason you want to change?",
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
                    child: Column(
                      children: [
                        _buildReasonOption("My health"),
                        const SizedBox(height: 10),
                        _buildReasonOption("My family"),
                        const SizedBox(height: 10),
                        _buildReasonOption("Save Money"),
                        const SizedBox(height: 10),
                        _buildReasonOption("To be free"),
                        const SizedBox(height: 10),
                        _buildReasonOption("To have a child"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 70),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedReasons.isNotEmpty) {
                        // Assign the selected reasons to the global variable
                        globals.raisonstopsmoking =
                            _selectedReasons; // Save the selected reasons

                        // Print to confirm the assignment
                        print("Selected Reasons: ${globals.raisonstopsmoking}");

                        // Navigate to the SmokingTriggersForm
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SmokingTriggersForm(),
                          ),
                        );
                      } else {
                        // Show a message if no reason is selected
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Please select at least one reason')),
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

  Widget _buildReasonOption(String reason) {
    bool isSelected =
        _selectedReasons.contains(reason); // Check if the reason is selected

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedReasons.remove(reason); // Deselect if already selected
          } else {
            _selectedReasons.add(reason); // Add to selected reasons
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF399918) : Colors.grey,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            reason,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFF399918) : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
