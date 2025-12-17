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

      actions: [_languageSwitcher(context, isDark), _themeSwitcher(isDark)],
    );
  }

  // ---------------------------
  // Language switcher
  // ---------------------------
  Widget _languageSwitcher(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D3440) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _langItem(
            text: "MN",
            active: isMN,
            onTap: () => CodermanApp.setLocale(context, const Locale('mn')),
            isDark: isDark,
          ),
          const SizedBox(width: 4),
          _langItem(
            text: "EN",
            active: !isMN,
            onTap: () => CodermanApp.setLocale(context, const Locale('en')),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _langItem({
    required String text,
    required bool active,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF1b2e51) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: active
                ? Colors.white
                : (isDark ? Colors.white70 : Colors.black54),
          ),
        ),
      ),
    );
  }

  // ---------------------------
  // Theme switcher
  // ---------------------------
  Widget _themeSwitcher(bool isDark) {
    return InkWell(
      onTap: onToggleTheme,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1b2e51) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            isDark ? Icons.wb_sunny_outlined : Icons.nights_stay_outlined,
            key: ValueKey(isDark),
            size: 20,
            color: isDark ? Colors.orange : Colors.black54,
          ),
        ),
      ),
    );
  }
}
