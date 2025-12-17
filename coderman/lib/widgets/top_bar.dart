import 'package:coderman/main.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onToggleTheme;
  final bool isMN;

  const TopBar({super.key, required this.onToggleTheme, required this.isMN});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: const Color(0xFF1A1F29),
      elevation: 0,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/head.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      titleSpacing: 1,

      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/images/top_logo.png",
              height: 47,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),

      actions: [
        _languageSwitcher(context, isDark, isMN),
        _themeSwitcher(isDark),
      ],
    );
  }

  // ---------------------------
  // Language switcher
  // ---------------------------
  Widget _languageSwitcher(BuildContext context, bool isDark, bool isMN) {
    return InkWell(
      onTap: () {
        CodermanApp.setLocale(
          context,
          isMN ? const Locale('en') : const Locale('mn'),
        );
      },
      child: isMN
          ? Image.asset("assets/images/en.png", height: 37, fit: BoxFit.contain)
          : Image.asset(
              "assets/images/mn.png",
              height: 37,
              fit: BoxFit.contain,
            ),
    );
  }

  // ---------------------------
  // Theme switcher
  // ---------------------------
  Widget _themeSwitcher(bool isDark) {
    return InkWell(
      onTap: onToggleTheme,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isDark
            ? Image.asset(
                "assets/images/light.png",
                height: 37,
                fit: BoxFit.contain,
              )
            : Image.asset(
                "assets/images/dark.png",
                height: 37,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
