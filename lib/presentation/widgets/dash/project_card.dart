import 'package:flutter/material.dart';

import '../../../core/themes/app_theme.dart';
import '../../../core/utils/date_format_mixin.dart';
import '../../../domain/entities/project_entity.dart';

class ProjectCard extends StatefulWidget {
  final ProjectEntity project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin, DateFormatMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _elevationAnimation = Tween<double>(begin: 4.0, end: 8.0).animate(
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
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: _onItemTap,
            onTapDown: (_) => _animationController.forward(),
            onTapUp: (_) => _animationController.reverse(),
            onTapCancel: () => _animationController.reverse(),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius:
                        _elevationAnimation.value, // <-- use animated elevation
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildItemContent(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemContent() {
    return AspectRatio(
      aspectRatio: 0.625, // Maintain
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Row: Icon and Title
          Row(
            children: [
              _buildIcon(),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.project.title.trim().isNotEmpty
                      ? widget.project.title
                      : 'Untitled',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
            ],
          ),
          // Description
          Container(
            alignment: Alignment.topLeft,
            height: 60, // Fixed height ensures consistent start position
            child: Text(
              widget.project.description.trim().isNotEmpty
                  ? widget.project.description
                  : 'No Description',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.white70, fontSize: 20),
            ),
          ),
          // Date
          Text(
            formatDate(widget.project.date),
            style: const TextStyle(color: Colors.white54, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(Icons.folder, color: Colors.white, size: 24),
    );
  }

  void _onItemTap() {
    // Handle item tap
    // TODO: Implement navigation or action on tap
    // Navigator.pushNamed(context, '/progress-detail', arguments: widget.project);
  }
}
