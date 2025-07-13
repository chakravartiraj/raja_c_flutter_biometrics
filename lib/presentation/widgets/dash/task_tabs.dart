import 'package:flutter/material.dart';

import '../../../core/themes/app_theme.dart';
import '../../../core/utils/responsive_helper.dart';

class TaskTabs extends StatefulWidget {
  final String selectedTab;
  final Function(String) onTabChanged;

  const TaskTabs({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  State<TaskTabs> createState() => _TaskTabsState();
}

class _TaskTabsState extends State<TaskTabs>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<String> tabs = ['My tasks', 'Project', 'Pendings'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTabs();
  }

  Widget _buildTabs() {
    return Row(children: tabs.map((tab) => _buildTab(tab)).toList());
  }

  Widget _buildTab(String tab) {
    final isSelected = widget.selectedTab == tab;

    // Updated implementation with selected tab highlighted by white box
    return GestureDetector(
      onTap: () => _onTabTap(tab),
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: isSelected ? _scaleAnimation.value : 1.0,
            child: Container(
              margin: const EdgeInsets.only(right: 24),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: isSelected
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      /*border: Border.all(
                        color: AppTheme.primaryColor,
                        width: 2,
                      ),*/
                    )
                  : const BoxDecoration(),
              child: Text(
                tab,
                style: TextStyle(
                  fontSize: ResponsiveHelper.isTablet(context) ? 18 : 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? AppTheme.primaryColor
                      : AppTheme.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onTabTap(String tab) {
    widget.onTabChanged(tab);
  }
}
