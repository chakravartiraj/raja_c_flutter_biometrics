import 'dart:ui';

import 'package:flutter/material.dart';

class LiquidGlassCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double blurSigma;
  final double maxWidth;

  const LiquidGlassCard({
    super.key,
    required this.child,
    this.borderRadius = 32,
    this.padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
    this.blurSigma = 18,
    this.maxWidth = 500,
  });

  @override
  State<LiquidGlassCard> createState() => _LiquidGlassCardState();
}

class _LiquidGlassCardState extends State<LiquidGlassCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _highlightController;

  @override
  void initState() {
    super.initState();
    _highlightController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _highlightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blurSigma,
              sigmaY: widget.blurSigma,
            ),
            child: Container(
              padding: widget.padding,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: widget.child,
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _highlightController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _LiquidGlassHighlightPainter(
                    _highlightController.value,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _LiquidGlassHighlightPainter extends CustomPainter {
  final double animationValue;

  _LiquidGlassHighlightPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3 * animationValue)
      ..style = PaintingStyle.fill;

    // Dynamic highlights
    canvas.drawOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 4),
        radius: 100,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height * 3 / 4),
        radius: 100,
      ),
      paint,
    );

    // Reflection
    paint.color = Colors.white.withValues(alpha: 0.1 * animationValue);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.6, size.width, size.height * 0.4),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
