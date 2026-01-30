import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:librarymanager/core/theme/app_theme.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double? size;
  final Color? color;
  const CustomLoadingIndicator({super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Icon(
                Icons
                    .auto_stories, // Using a book icon suitable for a library manager
                color: color ?? AppTheme.primaryBlue,
                size: size ?? 48,
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                duration: 800.ms,
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.2, 1.2),
                curve: Curves.easeInOut,
              )
              .fadeIn(duration: 500.ms),
    );
  }
}
