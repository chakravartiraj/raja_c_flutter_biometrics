import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/themes/app_theme.dart';
import '../screens/auth_screen.dart';
import '../screens/dash_screen.dart';
// import other screens as needed

class AppRoutes {
  static const String auth = '/auth';
  static const String dash = '/dash';
  // Add other route names here

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case dash:
        return MaterialPageRoute(builder: (_) => const DashScreen());
      // Add other routes here
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: AppTheme.backgroundColor,
            appBar: AppBar(title: const Text('Coming Soon')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.construction,
                    size: 64,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    kDebugMode
                        ? 'The page "${settings.name}" is under construction!'
                        : 'Coming Soon! Check back later...',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppTheme.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}
