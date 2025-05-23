import 'package:breathair_app/pages/login.dart';
import 'package:breathair_app/pages/welcome2.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/backgroundImg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          // Green overlay and content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: const Color(0xFF399918), // Green overlay
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(200),
                ),
              ),
              padding: const EdgeInsets.all(40),
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ImageIcon(
                    AssetImage("assets/robot.png"),
                    color: Colors.white,
                    size: 80,
                  ),
                  const Column(
                    children: [
                      Text(
                        "Congratulations!",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Quitting smoking is the best way to change your life for the better!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  // Continue button
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            setState(() {
                              _isLoading = true;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Welcome2()));
                            // Simulate a delay for loading state
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                _isLoading = false;
                              });
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.8,
                          50), // Responsive width
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            'Continue', // Changed label to "Continue"
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
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















// import 'package:flutter/material.dart';
// import 'package:breathair_app/pages/welcome2.dart';

// class Welcome extends StatefulWidget {
//   @override
//   _WelcomeState createState() => _WelcomeState();
// }

// class _WelcomeState extends State<Welcome> {
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             child: Image.asset(
//               "assets/backgroundImg.jpg",
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Custom curved overlay and content
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: ClipPath(
//               clipper:
//                   AsymmetricalDownwardCurveClipper(), // Custom clipper for the asymmetrical downward curve
//               child: Container(
//                 color: const Color(0xFF399918), // Green overlay
//                 padding: const EdgeInsets.all(5),
//                 height: 600,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const ImageIcon(
//                       AssetImage("assets/robot.png"),
//                       color: Colors.white,
//                       size: 80,
//                     ),
//                     const Column(
//                       children: [
//                         Text(
//                           "Congratulations!",
//                           style: TextStyle(
//                             fontSize: 24,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           "Quitting smoking is the best way to change your life for the better!",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                     // Continue button
//                     ElevatedButton(
//                       onPressed: _isLoading
//                           ? null
//                           : () {
//                               setState(() {
//                                 _isLoading = true;
//                               });
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Welcome2()));
//                               // Simulate a delay for loading state
//                               Future.delayed(const Duration(seconds: 2), () {
//                                 setState(() {
//                                   _isLoading = false;
//                                 });
//                               });
//                             },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         minimumSize: Size(
//                             MediaQuery.of(context).size.width * 0.8,
//                             50), // Responsive width
//                       ),
//                       child: _isLoading
//                           ? const CircularProgressIndicator(
//                               valueColor:
//                                   AlwaysStoppedAnimation<Color>(Colors.white),
//                             )
//                           : const Text(
//                               'Continue', // Changed label to "Continue"
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16,
//                               ),
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Custom clipper for the asymmetrical downward curve
// class AsymmetricalDownwardCurveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();

//     // Start from the top-left corner
//     path.lineTo(0, 150); // Taller height on the left

//     // Create the asymmetrical downward curve
//     var firstControlPoint =
//         Offset(size.width * 0.8, 250); // More curvature on the right
//     var firstEndPoint = Offset(
//         size.width, 150); // End of the curve at a lower height on the right

//     path.quadraticBezierTo(
//       firstControlPoint.dx,
//       firstControlPoint.dy,
//       firstEndPoint.dx,
//       firstEndPoint.dy,
//     );

//     // Draw straight lines for the rest of the box
//     path.lineTo(size.width, size.height); // Bottom right
//     path.lineTo(0, size.height); // Bottom left
//     path.close(); // Close the path

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
