import 'package:flutter/material.dart';

import '../../../core/themes/app_theme.dart';
import '../../../core/utils/date_format_mixin.dart';
import '../../../domain/entities/progress_entity.dart';
import '../../widgets/common/circular_icon_avatar.dart';

class ProgressItem extends StatefulWidget {
  final ProgressEntity progressItem;

  const ProgressItem({super.key, required this.progressItem});

  @override
  State<ProgressItem> createState() => _ProgressItemState();
}

class _ProgressItemState extends State<ProgressItem>
    with SingleTickerProviderStateMixin, DateFormatMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
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
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: _onItemTap,
            onTapDown: (_) => _animationController.forward(),
            onTapUp: (_) => _animationController.reverse(),
            onTapCancel: () => _animationController.reverse(),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.cardColor, // Corrected property name
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .04), // Fixed method
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircularIconAvatar(
                    icon: Icons.note_rounded,
                    size: 40,
                    backgroundColor: AppTheme.primaryColor,
                    iconColor: Colors.white,
                    iconSize: 24,
                    margin: EdgeInsets.only(right: 16.0),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.progressItem.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        /*const SizedBox(height: 4),
                        Text(
                          widget.progressItem.subtitle,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),*/
                        const SizedBox(height: 4),
                        Text(
                          timeAgo(widget.progressItem.timestamp),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.more_vert,
                    color: AppTheme.textSecondary,
                    size: 32,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onItemTap() {
    // TODO: Implement navigation or action on tap
  }
}
