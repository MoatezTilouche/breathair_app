import 'package:breathair_app/pages/appBar.dart';
import 'package:breathair_app/pages/blogCard.dart';
import 'package:breathair_app/pages/bottomBar.dart';
import 'package:flutter/material.dart';

class Blogspage extends StatefulWidget {
  const Blogspage({super.key});
  

  @override
  State<Blogspage> createState() => _BlogspageState();
}

class _BlogspageState extends State<Blogspage> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf6f6f6),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "For You ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Horizontally scrollable row of icons with titles
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    _buildIconWithTitle(
                      iconPath: "assets/nutrition.png",
                      title: "Nutrition",
                    ),
                    const SizedBox(width: 52),
                    _buildIconWithTitle(
                      iconPath: "assets/sport.png",
                      title: "Sport",
                    ),
                    const SizedBox(width: 52),
                    _buildIconWithTitle(
                      iconPath: "assets/running.png",
                      title: "Running",
                    ),
                    const SizedBox(width: 42),
                    _buildIconWithTitle(
                      iconPath: "assets/plus.png",
                      title: "Add more topics",
                    ),
                    // Add more icons with titles as needed
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Newest Blogs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Horizontally scrollable BlogCard section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    BlogCard(
                        category: 'Nutrition',
                        title: 'Learn more about apples!',
                        votes: 78,
                        imageUrl:
                            'https://images.unsplash.com/photo-1485527172732-c00ba1bf8929?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MTV8NDAxMzg3NTd8fGVufDB8fHx8fA%3D%3D'),
                    const SizedBox(width: 12),
                    BlogCard(
                        category: 'Lifestyle',
                        title: 'The secrets of maximizing your productivity',
                        votes: 54,
                        imageUrl:
                            'https://plus.unsplash.com/premium_photo-1682310140123-d479f37e2c88?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZHVjdGl2aXRlfGVufDB8fDB8fHww'),
                    // Add more BlogCards as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          DemoBottomAppBar(scaffoldKey: _scaffoldKey, selectedIndex: 2),
    );
  }

  // Helper function to build icon with title underneath
  Widget _buildIconWithTitle(
      {required String iconPath, required String title}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFf2fdef),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            iconPath,
            height: 50,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ],
    );
    
  }
}
