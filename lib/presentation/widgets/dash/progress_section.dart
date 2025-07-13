import 'package:flutter/material.dart';
import 'package:raja_c_flutter_biometrics/core/themes/app_theme.dart';
import '../../../domain/entities/progress_entity.dart';
import '../../../core/utils/responsive_helper.dart';
import 'progress_item.dart';

class ProgressSection extends StatefulWidget {
  final List<ProgressEntity> progressItems;
  final bool isTablet;

  const ProgressSection({
    super.key,
    required this.progressItems,
    this.isTablet = false,
  });

  @override
  State<ProgressSection> createState() => _ProgressSectionState();
}

class _ProgressSectionState extends State<ProgressSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _slideAnimations = List.generate(
      widget.progressItems.length,
      (index) => Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          index * 0.1,
          (index * 0.1) + 0.6,
          curve: Curves.easeOutCubic,
        ),
      )),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(),
          const SizedBox(height: 16),
          _buildProgressList(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Text(
      'Progress',
      style: TextStyle(
        fontSize: ResponsiveHelper.isTablet(context) ? 24 : 20,
        fontWeight: FontWeight.bold,
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildProgressList() {
    return Column(
      children: List.generate(
        widget.progressItems.length,
        (index) => AnimatedBuilder(
          animation: _slideAnimations[index],
          builder: (context, child) {
            return SlideTransition(
              position: _slideAnimations[index],
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: ProgressItem(
                  progressItem: widget.progressItems[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}