import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color>? gradientColors;
  final String? rightTopTag; // e.g., "12% Completed"
  const CourseCard({
    super.key,
    required this.title,
    required this.icon,
    this.gradientColors,
    this.rightTopTag,
  });

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ??
        [
          Theme.of(context).colorScheme.primary.withOpacity(0.9),
          Theme.of(context).colorScheme.primary,
        ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 160,
          color: Theme.of(context).cardColor,
          child: Column(
            children: [
              // top gradient area
              Expanded(
                flex: 7,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),

                    // TRENDING badge on top-left
                    Positioned(
                      left: 12,
                      top: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.accent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'TRENDING',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),

                    // optional right top small tag
                    if (rightTopTag != null)
                      Positioned(
                        right: 12,
                        top: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            rightTopTag!,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                    // center icon
                    Center(
                      child: Icon(
                        icon,
                        size: 56,
                        color: Colors.white.withOpacity(0.95),
                      ),
                    ),
                  ],
                ),
              ),

              // bottom title area
              Expanded(
                flex: 3,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
