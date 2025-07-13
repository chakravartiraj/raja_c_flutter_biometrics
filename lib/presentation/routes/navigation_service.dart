import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NavigationService {
  static Future<T?>? pushReplacementNamed<T extends Object?, TO extends Object?>(String routeName, {TO? result}) {
    return navigatorKey.currentState?.pushReplacementNamed<T, TO>(routeName, result: result);
  }

  static Future<T?>? pushNamed<T extends Object?>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState?.pushNamed<T>(routeName, arguments: arguments);
  }

  static void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop<T>(result);
  }

  // Add more helpers as needed
}
