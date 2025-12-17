import 'package:flutter/material.dart';

import '../widgets/lessoncard.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          LessonCard(
            level: 'Амархан',
            levelColor: Colors.green,
            title: 'Массивын хамгийн их утга',
            description:
                'Бүхэл тоон массив өгөгдөнө. Хамгийн их утгыг олоорой.',
            score: 15,
            completed: true,
          ),
          SizedBox(height: 12),
          LessonCard(
            level: 'Дунд',
            levelColor: Colors.orange,
            title: 'Fibonacci дараалал',
            description:
                'N-р Fibonacci тоог ол. Fibonacci дараалал нь 0, 1, 1, 2, 3, 5, 8...',
            score: 25,
            completed: false,
          ),
          SizedBox(height: 12),
          LessonCard(
            level: 'Дунд',
            levelColor: Colors.orange,
            title: 'Binary Tree эргүүлэх',
            description: 'Binary модыг эргүүлнэ үү (mirror).',
            score: 35,
            completed: false,
          ),
        ],
      ),
    );
  }
}
