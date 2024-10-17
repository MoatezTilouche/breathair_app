// import 'package:breathair_app/pages/forms/sexeForm.dart';
// import 'package:breathair_app/pages/speechBubble.dart';
// import 'package:flutter/material.dart';

// class NameForm extends StatefulWidget {
//   const NameForm({super.key});

//   @override
//   State<NameForm> createState() => _NameFormState();
// }

// class _NameFormState extends State<NameForm> {
//   final TextEditingController _nameController = TextEditingController();
//   bool _isLoading = false;
//   bool _isFieldSelected = false;

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
//           // Main content
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
//                       CustomPaint(
//                         painter: SpeechBubblePainter(),
//                         child: Container(
//                           padding: EdgeInsets.all(20),
//                           child: const Text(
//                             "What should we call you ? ",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 50),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: TextField(
//                       controller: _nameController,
//                       keyboardType: TextInputType.text,
//                       onTap: () {
//                         setState(() {
//                           _isFieldSelected = true;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Enter Your name',
//                         labelStyle: TextStyle(
//                           color: _isFieldSelected ? Colors.green : Colors.grey,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,

//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(
//                             color:
//                                 const Color(0xFF399918),
//                           ),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 70),
//                   ElevatedButton(
//                     onPressed: () {
//                       FocusScope.of(context).unfocus();

//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const SexeForm()));
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
//                               fontSize: 17,
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
import 'package:breathair_app/pages/forms/emailForm.dart';
import 'package:breathair_app/pages/speechBubble.dart';
import 'package:breathair_app/globals.dart'
    as globals; // Import the global variables

class NameForm extends StatefulWidget {
  const NameForm({super.key});

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _isLoading = false;
  bool _isNameFieldSelected = false;
  bool _isLastNameFieldSelected = false;

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
          // Main content
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
                      CustomPaint(
                        painter: SpeechBubblePainter(),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: const Text(
                            "What should we call you?",
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
                  // Name input
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      onTap: () {
                        setState(() {
                          _isNameFieldSelected = true;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Your First Name',
                        labelStyle: TextStyle(
                          color:
                              _isNameFieldSelected ? Colors.green : Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                  SizedBox(height: 20),
                  // Last Name input
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _lastNameController,
                      keyboardType: TextInputType.text,
                      onTap: () {
                        setState(() {
                          _isLastNameFieldSelected = true;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Your Last Name',
                        labelStyle: TextStyle(
                          color: _isLastNameFieldSelected
                              ? Colors.green
                              : Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                  SizedBox(height: 70),
                  // Continue Button
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      // Set global variables with user input
                      globals.nom = _nameController.text;
                      globals.prenom = _lastNameController.text;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EmailForm()));
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
                              fontSize: 17,
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
