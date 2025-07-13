import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raja_c_flutter_biometrics/domain/entities/dash_entity.dart';
import 'package:raja_c_flutter_biometrics/presentation/blocs/dash/dash_bloc.dart';
import 'package:raja_c_flutter_biometrics/presentation/blocs/dash/dash_event.dart';
import 'package:raja_c_flutter_biometrics/presentation/blocs/dash/dash_state.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/common/error_widget.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/common/loading_widget.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/dash/bottom_navigation.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/dash/dash_header.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/dash/progress_section.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/dash/project_card_section.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/dash/task_tabs.dart';

import '../../../core/themes/app_theme.dart';
import '../../../core/utils/responsive_helper.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadDashboardData();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  void _loadDashboardData() {
    context.read<DashboardBloc>().add(const LoadDashboardEvent());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildContent(state),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }

  Widget _buildContent(DashboardState state) {
    if (state is DashboardLoadingState) {
      return const LoadingWidget();
    }

    if (state is DashboardErrorState) {
      return CustomErrorWidget(
        message: state.message,
        onRetry: _loadDashboardData,
      );
    }

    if (state is DashboardLoadedState) {
      return _buildDashboardContent(state.dashboardData);
    }

    return const SizedBox.shrink();
  }

  Widget _buildDashboardContent(DashboardEntity dashboardData) {
    return ResponsiveHelper.isTablet(context)
        ? _buildTabletLayout(dashboardData)
        : _buildMobileLayout(dashboardData);
  }

  Widget _buildMobileLayout(DashboardEntity dashboardData) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          DashboardHeader(userData: dashboardData.userData),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 24),
                  TaskTabs(
                    selectedTab: dashboardData.selectedTab,
                    onTabChanged: (tab) => _onTabChanged(tab),
                  ),
                  const SizedBox(height: 24),
                  ProjectCardsSection(projects: dashboardData.projects),
                  const SizedBox(height: 32),
                  ProgressSection(progressItems: dashboardData.progressItems),
                  const SizedBox(height: 100), // Bottom padding for navigation
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(DashboardEntity dashboardData) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardHeaderHorizontal(userData: dashboardData.userData),
                  const SizedBox(height: 32),
                  TaskTabs(
                    selectedTab: dashboardData.selectedTab,
                    onTabChanged: (tab) => _onTabChanged(tab),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: ProjectCardsSection(
                      projects: dashboardData.projects,
                      isTablet: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80), // Align with content
                  Expanded(
                    child: ProgressSection(
                      progressItems: dashboardData.progressItems,
                      isTablet: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTabChanged(String tab) {
    context.read<DashboardBloc>().add(ChangeTabEvent(tab));
  }
}
