import 'package:coderman/widgets/top_bar.dart';
import 'package:flutter/material.dart';

// THEME DEFINITIONS
final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.grey.shade100,

  appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: Color(0xFF0F0F0F),
  cardColor: Color(0xFF1A1A1A),
  appBarTheme: AppBarTheme(backgroundColor: Color(0xFF1C1C1C)),
);

void main() {
  runApp(CodermanApp());
}

class CodermanApp extends StatefulWidget {
  @override
  State<CodermanApp> createState() => _CodermanAppState();
}

class _CodermanAppState extends State<CodermanApp> {
  ThemeMode _themeMode = ThemeMode.light;
  String _lang = 'MN';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: HomePage(
        lang: _lang,
        onToggleLang: () {
          setState(() {
            _lang = _lang == 'MN' ? 'EN' : 'MN';
          });
        },
        onToggleTheme: () {
          setState(() {
            _themeMode = _themeMode == ThemeMode.light
                ? ThemeMode.dark
                : ThemeMode.light;
          });
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final VoidCallback onToggleLang;
  final String lang;

  const HomePage({
    required this.lang,
    required this.onToggleTheme,
    required this.onToggleLang,
  });

  @override
  Widget build(BuildContext context) {
    bool isMN = lang == 'MN';

    return Scaffold(
      appBar: TopBar(
        onToggleTheme: onToggleTheme,
        onMN: isMN ? () {} : onToggleLang,
        onEN: isMN ? onToggleLang : () {},
        isMN: isMN,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMN ? 'Тавтай морил,' : 'Welcome,',
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'CODERMAN',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    isMN
                        ? 'Бүтээмжээ нээ. Код бичиж эхлээрэй!'
                        : 'Unlock Your Potential. Start Coding!',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildCard(Icons.emoji_events, isMN ? 'Ранк' : 'Rank', '#25'),
            _buildCard(
              Icons.access_time,
              isMN ? 'Хичээл хийсэн цаг' : 'Learning Hours',
              '32',
            ),
            _buildCard(
              Icons.bubble_chart,
              isMN ? 'Бодсон бодлого' : 'Solved Problems',
              '45',
            ),
            _buildCard(
              Icons.trending_up,
              isMN ? 'Тэмцээний амжилт' : 'Contest Success',
              '68%',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: isMN ? 'Нүүр' : 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: isMN ? 'Код' : 'Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: isMN ? 'Ранк' : 'Rank',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: isMN ? 'Профайл' : 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCard(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white24,
                ),
                child: Icon(icon, color: Colors.amber),
              ),
              SizedBox(width: 12),
              Text(title, style: TextStyle(fontSize: 18)),
            ],
          ),
          Text(
            value,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
