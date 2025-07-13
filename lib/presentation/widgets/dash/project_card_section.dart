import 'package:flutter/material.dart';

import '../../../domain/entities/project_entity.dart';
import 'project_card.dart';

class ProjectCardsSection extends StatefulWidget {
  final List<ProjectEntity> projects;
  final bool isTablet;

  const ProjectCardsSection({
    super.key,
    required this.projects,
    this.isTablet = false,
  });

  @override
  State<ProjectCardsSection> createState() => _ProjectCardsSectionState();
}

class _ProjectCardsSectionState extends State<ProjectCardsSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimations = List.generate(
      widget.projects.length,
      (index) =>
          Tween<Offset>(
            begin: Offset(0, 0.5 + (index * 0.1)),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Interval(
                index * 0.1,
                (index * 0.1) + 0.6,
                curve: Curves.easeOutCubic,
              ),
            ),
          ),
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
    if (widget.isTablet) {
      return _buildTabletLayout();
    }
    return _buildMobileLayout();
  }

  Widget _buildMobileLayout() {
    final double cardWidth = 220;
    final double viewportFraction =
        cardWidth / MediaQuery.of(context).size.width;
    return SizedBox(
      height: 270,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: viewportFraction,
          initialPage: 0,
        ),
        itemCount: widget.projects.length,
        padEnds: false, // Ensures first item starts from the left
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _slideAnimations[index],
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimations[index],
                child: Container(
                  width: cardWidth,
                  margin: EdgeInsets.only(
                    right: index == widget.projects.length - 1 ? 0 : 16,
                  ),
                  child: ProjectCard(project: widget.projects[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTabletLayout() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: widget.projects.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _slideAnimations[index],
          builder: (context, child) {
            return SlideTransition(
              position: _slideAnimations[index],
              child: ProjectCard(project: widget.projects[index]),
            );
          },
        );
      },
    );
  }
}
