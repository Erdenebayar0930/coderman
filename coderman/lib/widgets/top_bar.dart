import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onToggleTheme;
  final VoidCallback onMN;
  final VoidCallback onEN;
  final bool isMN; // идэвхтэй хэл

  const TopBar({
    super.key,
    required this.onToggleTheme,
    required this.onMN,
    required this.onEN,
    required this.isMN,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: const Color(0xFF1A1F29),
      elevation: 0,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset("assets/images/top_logo.png", height: 38),
            ),
          ],
        ),
      ),

      actions: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2D3440) : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // MN
              InkWell(
                onTap: onMN,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isMN
                        ? const Color.fromARGB(255, 2, 45, 69)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "MN",
                    style: TextStyle(
                      color: isMN
                          ? Colors.white
                          : (isDark ? Colors.white70 : Colors.black54),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 6),

              // EN
              InkWell(
                onTap: onEN,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isMN
                        ? Colors.transparent
                        : const Color.fromARGB(255, 2, 45, 69),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "EN",
                    style: TextStyle(
                      color: isMN
                          ? (isDark ? Colors.white70 : Colors.black54)
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ---------------------------
        //       THEME SWITCH
        // ---------------------------
        InkWell(
          onTap: onToggleTheme,
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2D3440) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isDark ? Icons.wb_sunny_outlined : Icons.nights_stay_outlined,
              color: isDark ? Colors.white70 : Colors.black54,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
