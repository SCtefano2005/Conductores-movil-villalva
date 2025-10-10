import 'package:flutter/material.dart';

class AppNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static void navigateToHome() {
    navigatorKey.currentState?.pushReplacementNamed('/home');
  }

  static void navigateToLogin() {
    navigatorKey.currentState?.pushReplacementNamed('/login');
  }
}
