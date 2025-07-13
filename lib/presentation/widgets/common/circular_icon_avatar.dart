import 'package:flutter/material.dart';

import '../../../core/themes/app_theme.dart';

class CircularIconAvatar extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const CircularIconAvatar({
    super.key,
    required this.icon,
    this.size = 40,
    this.backgroundColor = AppTheme.primaryColor,
    this.iconColor = Colors.white,
    this.iconSize = 24,
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ?? const EdgeInsets.only(right: 16.0),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: iconSize),
      ),
    );
  }
}
