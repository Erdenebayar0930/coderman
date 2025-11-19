import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/section_title.dart';
import '../widgets/course_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // small helper gradients for variation
    final purpleGradient = [
      const Color(0xFF8E2DE2),
      const Color(0xFF4A00E0),
    ];

    final blueGradient = [
      const Color(0xFF3A8DFF),
      const Color(0xFF6B6BFF),
    ];

    final orangeGradient = [
      const Color(0xFFFF8A00),
      const Color(0xFFD46B00),
    ];

    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/images/coderman.png', width: 64, height: 64, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 12),
                    const Text('Coderman', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              ListTile(leading: const Icon(Icons.home), title: const Text('Home')),
              ListTile(leading: const Icon(Icons.person), title: const Text('Profile')),
              ListTile(leading: const Icon(Icons.settings), title: const Text('Settings')),
            ],
          ),
        ),
      ),
      appBar: const TopBar(title: 'Courses'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle("MOST RECOMMENDED"),
            const SizedBox(height: 6),

            // grid 2 columns
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.05,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CourseCard(title: 'Python', icon: Icons.code, gradientColors: purpleGradient),
                CourseCard(title: 'Ethical Hacking', icon: Icons.lock, gradientColors: blueGradient),
                CourseCard(title: 'Java', icon: Icons.coffee, gradientColors: purpleGradient),
                CourseCard(title: 'HTML', icon: Icons.public, gradientColors: blueGradient),
              ],
            ),

            const SizedBox(height: 22),
            const SectionTitle("LEARNER'S CHOICE"),
            const SizedBox(height: 8),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.05,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CourseCard(title: 'JS', icon: Icons.javascript, gradientColors: orangeGradient),
                CourseCard(title: 'C++', icon: Icons.memory, gradientColors: [Color(0xFFFFC08A), Color(0xFFD98F3C)], rightTopTag: '12% Completed'),
              ],
            ),

            const SizedBox(height: 26),
            // extra bottom padding so bottom nav doesn't hide content
            SizedBox(height: MediaQuery.of(context).padding.bottom + 60),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.workspace_premium), label: 'Pro'),
        ],
      ),
    );
  }
}
