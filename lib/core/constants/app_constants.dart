class AppConstants {
  // App Information
  static const String appName = 'Psycho';
  static const String appVersion = '1.0.0';

  // Color Palette (from README)
  static const int sereneBlue = 0xFF3A7CA5;
  static const int mintGreen = 0xFF7ED6C1;
  static const int softLavender = 0xFFC8BFE7;
  static const int warmSand = 0xFFF2E8DC;
  static const int pureWhite = 0xFFFFFFFF;
  static const int charcoalGray = 0xFF2E2E2E;

  // Typography
  static const String fontFamily = 'Inter';

  // Base values for responsive scaling (these will be scaled by Responsive class)
  static const double baseSpacing = 16.0;
  static const double baseFontSize = 16.0;
  static const double baseBorderRadius = 20.0;
  static const double baseButtonHeight = 48.0;

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // Text Constants
  static const String welcomeTitle = 'Welcome to Psycho';
  static const String welcomeSubtitle = 'Your mental health companion';
  static const String loginTitle = 'Welcome Back';
  static const String signupTitle = 'Create Account';
  static const String forgotPasswordTitle = 'Reset Password';

  // Error Messages
  static const String emailRequired = 'Email is required';
  static const String passwordRequired = 'Password is required';
  static const String invalidEmail = 'Please enter a valid email';
  static const String passwordTooShort =
      'Password must be at least 6 characters';
  static const String passwordsDontMatch = 'Passwords do not match';
  static const String genericError = 'Something went wrong. Please try again.';

  // Success Messages
  static const String loginSuccess = 'Welcome back!';
  static const String signupSuccess = 'Account created successfully!';
  static const String passwordResetSent = 'Password reset email sent!';

  // User Roles
  static const String roleTherapist = 'therapist';
  static const String roleClient = 'client';

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String sessionsCollection = 'sessions';

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';
}
