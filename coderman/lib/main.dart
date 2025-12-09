import 'package:coderman/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:coderman/theme/app_theme.dart';

import 'pages/profile_screen.dart';

void main() {
  runApp(CodermanApp());
}

class CodermanApp extends StatefulWidget {
  @override
  State<CodermanApp> createState() => _CodermanAppState();
}

class _CodermanAppState extends State<CodermanApp> {
  ThemeMode _themeMode = ThemeMode.light;
  String _lang = 'EN';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
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

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final VoidCallback onToggleLang;
  final String lang;

  HomePage({
    required this.lang,
    required this.onToggleTheme,
    required this.onToggleLang,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isMN = widget.lang == 'MN';

    return Scaffold(
      appBar: TopBar(
        onToggleTheme: widget.onToggleTheme,
        onMN: isMN ? () {} : widget.onToggleLang,
        onEN: isMN ? widget.onToggleLang : () {},
        isMN: isMN,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 120, // 👉 нийт өндөр (background + navbar)
        child: Stack(
          children: [
            // ⬇️ Background — илүү өндөр
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 62, // 👉 хүссэнээрээ өндөр болгож болно
                decoration: const BoxDecoration(
                  color: const Color(0xFF1A1F29), // 👍 background color
                  border: Border(
                    top: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
            ),

            // ⬆️ BottomNavigationBar өөрөө
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent, // 👉 bgгүй байх ёстой
                selectedItemColor: Colors.white,
                selectedFontSize: 13,
                elevation: 0,
                currentIndex: _currentIndex,
                showUnselectedLabels: false,
                onTap: (index) {
                  setState(() => _currentIndex = index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      _currentIndex == 0
                          ? 'assets/images/lesson.png'
                          : 'assets/images/lesson_1.png',
                      width: 55,
                    ),
                    label: isMN ? "Хичээл" : "Lessons",
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      _currentIndex == 1
                          ? 'assets/images/challenge.png'
                          : 'assets/images/challenge_1.png',
                      width: 55,
                    ),
                    label: isMN ? "Бодлогууд" : "Challenges",
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      _currentIndex == 2
                          ? 'assets/images/profile.png'
                          : 'assets/images/profile_1.png',
                      width: 55,
                    ),
                    label: isMN ? "Профайл" : "Profile",
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      _currentIndex == 3
                          ? 'assets/images/leadership.png'
                          : 'assets/images/leadership_1.png',
                      width: 55,
                    ),
                    label: isMN ? "Манлайлал" : "Leadership",
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      _currentIndex == 4
                          ? 'assets/images/other.png'
                          : 'assets/images/other_1.png',
                      width: 55,
                    ),
                    label: isMN ? "Бусад апп" : "Other apps",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
