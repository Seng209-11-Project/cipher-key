class AppConstants {
  static const String appName = 'Password Generator';
  static const String appDescription = 'Create strong and secure passwords';

  // Password generation constants
  static const int minPasswordLength = 4;
  static const int maxPasswordLength = 32;
  static const int defaultPasswordLength = 12;

  // Character sets
  static const String lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
  static const String uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const String numberChars = '0123456789';
  static const String symbolChars = '!@#\$%^&*()_-+=<>?/[]{}|';
}