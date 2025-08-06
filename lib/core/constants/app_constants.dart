class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'http://localhost:8080/api'; // バックエンドのURLを想定
  static const String apiVersion = 'v1';

  // Routes
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String chatRoute = '/chat';
  static const String travelRoute = '/travel';
  static const String profileRoute = '/profile';
  static const String splashRoute = '/';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userProfileKey = 'user_profile';
  static const String chatHistoryKey = 'chat_history';

  // App Info
  static const String appName = 'Travel Agent AI';
  static const String appVersion = '1.0.0';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double buttonHeight = 48.0;

  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration loadingAnimationDuration = Duration(milliseconds: 1500);
}
