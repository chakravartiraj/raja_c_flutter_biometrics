enum AppRoute {
  auth,
  dash,
  // Add more routes as needed
}

extension AppRouteExtension on AppRoute {
  String get name {
    switch (this) {
      case AppRoute.auth:
        return '/auth';
      case AppRoute.dash:
        return '/dash';
      // Add more cases as needed
    }
  }
}
