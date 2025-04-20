// import 'package:breathair_app/constants.dart';
// import 'package:breathair_app/pages/blogsPage.dart';
// import 'package:breathair_app/pages/home.dart';
// import 'package:breathair_app/pages/login.dart';
// import 'package:breathair_app/pages/moneyChart.dart';
// import 'package:breathair_app/pages/moneyStatsPage.dart';
// import 'package:flutter/material.dart';

// class DemoBottomAppBar extends StatefulWidget {
//   const DemoBottomAppBar({
//     Key? key,
//     this.fabLocation = FloatingActionButtonLocation.centerDocked,
//     this.shape = const CircularNotchedRectangle(),
//     required this.scaffoldKey,
//     required this.selectedIndex,
//   }) : super(key: key);

//   final FloatingActionButtonLocation fabLocation;
//   final NotchedShape? shape;
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   final int selectedIndex;

//   @override
//   _DemoBottomAppBarState createState() => _DemoBottomAppBarState();
// }

// class _DemoBottomAppBarState extends State<DemoBottomAppBar> {
//   late int _selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex = widget.selectedIndex;
//   }
//   void _incrementAndNavigate(BuildContext context) {
//   setState(() {
//     compt_cig++;
//   });
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => const Home()),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       shape: widget.shape,
//       color: Colors.white,
//       child: IconTheme(
//         data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             // First Tab
//             _buildTabItem(
//               index: 0,
//               icon: const ImageIcon(AssetImage("assets/home.png")),
//               text: 'Home',
//               navigateTo: const Home(),
//             ),
//             // Spacer to add space between icons
//             const Spacer(),

//             _buildTabItem(
//               index: 2,
//               icon: const ImageIcon(AssetImage("assets/livre.png")),
//               text: 'Read',
//               navigateTo: const Blogspage(),
//             ),
//             // Spacer to add space between icons
//             const Spacer(),
//             _buildTabItem(
//               index: 1,
//               icon: Container(
//                 padding: const EdgeInsets.only(
//                     bottom: 7.0), // Move the icon slightly upwards
//                 decoration: BoxDecoration(
//                   color: Colors.green, // Set the background color to green
//                   borderRadius: BorderRadius.circular(
//                       8.0), // Optional: Add rounded corners
//                 ),
//                 child: const Icon(
//                   Icons.add,
//                   color: Colors
//                       .white, // Set the icon color to white for better contrast
//                 ),
//               ),
//               text: 'ADD CIG',
//               navigateTo: const Home() ,
//             ),
//             const Spacer(),
//             _buildTabItem(
//               index: 3,
//               icon: const Icon(Icons.stacked_line_chart),
//               text: 'Stats',
//               navigateTo: const StepsPage(),
//             ),
//             const Spacer(),
//             _buildTabItem(
//               index: 4,
//               icon: const ImageIcon(AssetImage("assets/user.png")),
//               text: 'Profile',
//               navigateTo: const Home(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTabItem({
//     required int index,
//     required Widget icon,
//     required String text,
//     required Widget navigateTo,
//     VoidCallback? onTap,
//   }) {
//     final isSelected = _selectedIndex == index;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedIndex = index;
//         });
//         if (onTap != null) {
//           onTap();
//         } else {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => navigateTo),
//           );
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconTheme(
//             data: IconThemeData(
//               color: isSelected ? const Color(0xFF399918) : Colors.grey,
//             ),
//             child: icon,
//           ),
//           const SizedBox(height: 5),
//           Text(
//             text,
//             style: TextStyle(
//               color: isSelected ? const Color(0xFF399918) : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:breathair_app/constants.dart';
import 'package:breathair_app/pages/blogsPage.dart';
import 'package:breathair_app/pages/home.dart';
import 'package:breathair_app/pages/login.dart';
import 'package:breathair_app/pages/moneyChart.dart';
import 'package:breathair_app/pages/moneyStatsPage.dart';
import 'package:breathair_app/pages/relapse_form_page.dart';
import 'package:breathair_app/pages/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DemoBottomAppBar extends StatefulWidget {
  const DemoBottomAppBar({
    Key? key,
    this.fabLocation = FloatingActionButtonLocation.centerDocked,
    this.shape = const CircularNotchedRectangle(),
    required this.scaffoldKey,
    required this.selectedIndex,
  }) : super(key: key);

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int selectedIndex;

  @override
  _DemoBottomAppBarState createState() => _DemoBottomAppBarState();
}

class _DemoBottomAppBarState extends State<DemoBottomAppBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _showRelapseForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: RelapseFormPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: widget.shape,
      color: Colors.white,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // First Tab
            _buildTabItem(
              index: 0,
              icon: const ImageIcon(AssetImage("assets/home.png")),
              text: 'Home',
              navigateTo: const Home(),
            ),
            // Spacer to add space between icons
            const Spacer(),
            _buildTabItem(
              index: 2,
              icon: const ImageIcon(AssetImage("assets/livre.png")),
              text: 'Read',
              navigateTo: const Blogspage(),
            ),
            // Spacer to add space between icons
            const Spacer(),
            _buildTabItem(
              index: 1,
              icon: Container(
                padding: const EdgeInsets.only(bottom: 7.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              text: 'ADD CIG',
              onTap: () async {
                setState(() {
                  compt_cig++;
                  _selectedIndex = 1;
                });

                // Show the relapse form
                _showRelapseForm(context);

                // Fetch the token
                AuthService authService = AuthService();
                String? token = await authService.getToken();

                if (token == null) {
                  throw Exception('Token not found');
                }

                // Send PATCH request to update cigarette stats and increment total cigarettes
                final response = await http.patch(
                  Uri.parse(
                      'http://localhost:3000/users/671a51d15f00744eec1a43f7/update-cigarette-stats'),
                  headers: {
                    'Authorization': 'Bearer $token',
                    'Content-Type': 'application/json',
                  },
                );

                if (response.statusCode != 200) {
                  throw Exception(
                      'Failed to update cigarette stats and increment total cigarettes');
                }

                var responseData = json.decode(response.body);

                // Reload the current page after successful update

                return responseData;
              },
            ),
            const Spacer(),
            _buildTabItem(
              index: 3,
              icon: const Icon(Icons.stacked_line_chart),
              text: 'Stats',
              navigateTo: const StepsPage(),
            ),
            const Spacer(),
            _buildTabItem(
              index: 4,
              icon: const ImageIcon(AssetImage("assets/user.png")),
              text: 'Profile',
              navigateTo: const Home(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required Widget icon,
    required String text,
    Widget? navigateTo,
    VoidCallback? onTap,
  }) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        if (onTap != null) {
          onTap();
        } else if (navigateTo != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => navigateTo),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTheme(
            data: IconThemeData(
              color: isSelected ? const Color(0xFF399918) : Colors.grey,
            ),
            child: icon,
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              color: isSelected ? const Color(0xFF399918) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
