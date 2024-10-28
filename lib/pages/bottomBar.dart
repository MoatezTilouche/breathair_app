import 'package:breathair_app/pages/blogsPage.dart';
import 'package:breathair_app/pages/login.dart';
import 'package:flutter/material.dart';

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
              navigateTo: const Login(),
            ),
            // Spacer to add space between icons
            const Spacer(),
            _buildTabItem(
              index: 1,
              icon: const ImageIcon(AssetImage("assets/montagne.png")),
              text: 'Challenge',
              navigateTo: const Login(),
            ),
            const Spacer(),
            // Third Tab
            _buildTabItem(
              index: 2,
              icon: const ImageIcon(AssetImage("assets/livre.png")),
              text: 'Read',
              navigateTo: const Blogspage(),
            ),
            // Spacer to add space between icons
            const Spacer(),
            _buildTabItem(
              index: 3,
              icon: const Icon(Icons.people),
              text: 'Comunity',
              navigateTo: const Login(),
            ),
            const Spacer(),
            _buildTabItem(
              index: 4,
              icon: const ImageIcon(AssetImage("assets/user.png")),
              text: 'Profile',
              navigateTo: const Login(),
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
    required Widget navigateTo,
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
        } else {
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
