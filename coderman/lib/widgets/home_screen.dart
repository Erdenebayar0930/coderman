import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Unlock Your Potential. Start Coding!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildCourseCard(
                'Python',
                'Introduction to Python',
                20880,
                -10015,
              ),
              _buildCourseCard('Web', 'Web Development Basics', 20030, -10015),
              _buildCourseCard('Algo', 'Daily Algorithm Problems', 120, 0),
              _buildCourseCard('Contest', 'Weekly Contest', 1542, 25000),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(String icon, String title, int score, int extra) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (score.toDouble() / (score + extra).abs()),
            ),
            const SizedBox(height: 4),
            Text('Score: $score'),
          ],
        ),
      ),
    );
  }
}
