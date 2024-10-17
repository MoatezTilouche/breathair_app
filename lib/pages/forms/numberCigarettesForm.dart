// import 'package:breathair_app/pages/forms/priceCigaretteForm.dart';
// import 'package:breathair_app/pages/forms/raisonForm.dart';
// import 'package:breathair_app/pages/speechBubble.dart';
// import 'package:flutter/material.dart';

// class NumberCigarettesForm extends StatefulWidget {
//   const NumberCigarettesForm ({super.key});

//   @override
//   State<NumberCigarettesForm > createState() => _NumberCigarettesForm();
// }

// class _NumberCigarettesForm  extends State<NumberCigarettesForm > {
//   final TextEditingController _nbCigarettesController = TextEditingController();
//   bool _isFieldSelected = false;
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus(); // Close the keyboard when tapping outside
//         },
//         child: Stack(
//           children: [
//             Container(
//               width: double.infinity,
//               height: double.infinity,
//               child: Image.asset(
//                 "assets/backgroundImg.jpg",
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(5, 70, 5, 0),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         const ImageIcon(
//                           AssetImage("assets/robot.png"),
//                           color: Color(0xFF399918),
//                           size: 100,
//                         ),
//                         CustomPaint(
//                           painter: SpeechBubblePainter(),
//                           child: Container(
//                             padding: EdgeInsets.all(20),
//                             child: const Text(
//                               "How many cigarettes per day?",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                                textAlign: TextAlign.center,
//                               softWrap: true, 
//                               overflow: TextOverflow.visible,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 50),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: TextField(
//                         controller:  _nbCigarettesController,
//                         keyboardType: TextInputType.number,
//                         onTap: () {
//                           setState(() {
//                             _isFieldSelected = true;
//                           });
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Enter average number',
//                           labelStyle: TextStyle(
//                             color: _isFieldSelected ? Colors.green : Colors.grey,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                               color: const Color(0xFF399918), // Green when selected
//                             ),
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 70),

//                     ElevatedButton(
//                       onPressed: () {
//                         FocusScope.of(context).unfocus(); 
//                         setState(() {
//                           _isLoading = true;
//                         });
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>const PriceOfCigaretteForm()));
//                         Future.delayed(Duration(seconds: 2), () {
//                           setState(() {
//                             _isLoading = false;
//                           });
//                           print("Number of cigarettes: ${ _nbCigarettesController.text}");
//                         });
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF399918),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         minimumSize: const Size(300, 40),
//                       ),
//                       child: _isLoading
//                           ? const CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             )
//                           : const Text(
//                               'Continue',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                               ),
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'package:breathair_app/pages/forms/priceCigaretteForm.dart';
import 'package:breathair_app/pages/forms/raisonForm.dart';
import 'package:breathair_app/pages/speechBubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importing for input formatters
import 'package:breathair_app/globals.dart' as globals; // Import your globals file

class NumberCigarettesForm extends StatefulWidget {
  const NumberCigarettesForm({super.key});

  @override
  State<NumberCigarettesForm> createState() => _NumberCigarettesForm();
}

class _NumberCigarettesForm extends State<NumberCigarettesForm> {
  final TextEditingController _nbCigarettesController = TextEditingController();
  bool _isFieldSelected = false;
  bool _isLoading = false;

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
                            padding: const EdgeInsets.all(20),
                            child: const Text(
                              "How many cigarettes per day?",
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
                      ],
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _nbCigarettesController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly, // Allow only digits
                        ],
                        onTap: () {
                          setState(() {
                            _isFieldSelected = true;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter average number',
                          labelStyle: TextStyle(
                            color: _isFieldSelected ? Colors.green : Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: const Color(0xFF399918), // Green when selected
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
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _isLoading = true;
                        });

                        // Assign the input value to the global variable
                        globals.nbcigaretteinitial = int.tryParse(_nbCigarettesController.text) ?? 0;

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PriceOfCigaretteForm()),
                        );

                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() {
                            _isLoading = false;
                          });
                          print("Number of cigarettes: ${globals.nbcigaretteinitial}");
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

