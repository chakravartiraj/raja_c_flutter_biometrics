import 'package:flutter/material.dart';
import 'package:raja_c_flutter_biometrics/core/themes/app_theme.dart';
import 'package:raja_c_flutter_biometrics/presentation/routes/navigation_service.dart';

import '../../../../domain/entities/user_entity.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../widgets/common/circular_icon_avatar.dart';

class DashboardHeaderHorizontal extends StatelessWidget {
  final UserEntity userData;

  const DashboardHeaderHorizontal({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            color: AppTheme.textPrimary,
            onPressed: () => _onMenuPressed(context),
          ),
          const Spacer(),
          CircularIconAvatar(
            icon: Icons.person,
            size: 40,
            backgroundColor: AppTheme.primaryColor,
            iconColor: Colors.white,
            iconSize: 24,
            margin: const EdgeInsets.only(right: 16.0),
            onTap: () {
              // Handle widget tap, e.g., navigate to profile
              // NavigationService.pushNamed('/profile');
            },
          ),
        ],
      ),
    );
  }

  void _onMenuPressed(BuildContext context) {
    // Handle menu press
    Scaffold.of(context).openDrawer();
  }
}

class DashboardHeader extends SliverAppBar {
  final UserEntity userData;

  DashboardHeader({
    super.key,
    required this.userData,
    // You can add more SliverAppBar specific properties here if needed,
    // like pinned, floating, snap, expandedHeight, etc.
    // For a fixed-height app bar, toolbarHeight is often sufficient.
  }) : super(
         // Properties for SliverAppBar
         toolbarHeight: kToolbarHeight, // Standard height for a toolbar
         backgroundColor:
             AppTheme.backgroundColor, // Set your desired background color
         elevation: 0, // No shadow by default, adjust as needed
         pinned: false, // Keeps the app bar visible at the top when scrolling
         floating: true, // Allows the app bar to float above the content
         snap: false, // Allows the app bar to snap into view when scrolling
         // Automatically sets the leading widget (usually a menu icon)
         leading: Builder(
           // Builder is used to get a context that can find the nearest Scaffold
           builder: (BuildContext context) {
             return IconButton(
               icon: const Icon(Icons.menu),
               color: AppTheme.textPrimary,
               onPressed: () {
                 // This is the standard way to open the drawer
                 Scaffold.of(context).openDrawer();
               },
             );
           },
         ),
         // Automatically sets the actions widgets (trailing widgets)
         actions: [
           CircularIconAvatar(
             icon: Icons.person,
             size: 40,
             backgroundColor: AppTheme.primaryColor,
             iconColor: Colors.white,
             iconSize: 24,
             margin: const EdgeInsets.only(right: 16.0),
             onTap: () {
               // Handle widget tap, e.g., navigate to profile
               // NavigationService.pushNamed('/profile');
             },
           ),
         ],
         // The _buildGreeting widget will now be in the bottom section
         bottom: _buildGreeting(),
         // If you need more complex layout than just leading/title/actions,
         // you would use flexibleSpace. For this simple case, leading/actions are enough.
       );

  static PreferredSize _buildGreeting() {
    final context = navigatorKey.currentState!.context;
    return PreferredSize(
      preferredSize: Size.fromHeight(
        ResponsiveHelper.isTablet(context) ? 80.0 : 70.0,
      ), // Adjust height as needed
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0), // Add padding
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Sriram!',
                style: TextStyle(
                  fontSize: ResponsiveHelper.isTablet(context) ? 32 : 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Have a nice day!',
                style: TextStyle(
                  fontSize: ResponsiveHelper.isTablet(context) ? 18 : 16,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // The _onMenuPressed method is no longer needed as a separate method
  // because its logic is directly embedded in the onPressed of the leading IconButton.
}
