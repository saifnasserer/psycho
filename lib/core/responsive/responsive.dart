import 'package:flutter/material.dart';

class Responsive {
  // Dynamic breakpoints based on screen size
  static double get _mobileBreakpoint => 600;
  static double get _tabletBreakpoint => 900;
  static double get _desktopBreakpoint => 1200;

  // Screen size helpers
  static Size getScreenSize(BuildContext context) =>
      MediaQuery.of(context).size;
  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double getPixelRatio(BuildContext context) =>
      MediaQuery.of(context).devicePixelRatio;
  static EdgeInsets getPadding(BuildContext context) =>
      MediaQuery.of(context).padding;
  static EdgeInsets getViewInsets(BuildContext context) =>
      MediaQuery.of(context).viewInsets;

  // Responsive breakpoint checks
  static bool isMobile(BuildContext context) =>
      getScreenWidth(context) < _mobileBreakpoint;
  static bool isTablet(BuildContext context) =>
      getScreenWidth(context) >= _mobileBreakpoint &&
      getScreenWidth(context) < _tabletBreakpoint;
  static bool isDesktop(BuildContext context) =>
      getScreenWidth(context) >= _desktopBreakpoint;
  static bool isLandscape(BuildContext context) =>
      getScreenWidth(context) > getScreenHeight(context);
  static bool isPortrait(BuildContext context) =>
      getScreenHeight(context) > getScreenWidth(context);

  // Dynamic spacing based on screen size
  static double getSpacing(BuildContext context, double baseSpacing) {
    final width = getScreenWidth(context);
    final height = getScreenHeight(context);
    final smallestDimension = width < height ? width : height;

    // Scale based on screen size
    if (smallestDimension < 400) {
      return baseSpacing * 0.8; // Small screens
    } else if (smallestDimension < 600) {
      return baseSpacing; // Medium screens
    } else if (smallestDimension < 900) {
      return baseSpacing * 1.2; // Large screens
    } else {
      return baseSpacing * 1.5; // Extra large screens
    }
  }

  // Dynamic padding based on screen size and orientation
  static EdgeInsets getDynamicPadding(
    BuildContext context, {
    double? basePadding,
  }) {
    final base = basePadding ?? 16.0;
    // final width = getScreenWidth(context);
    // final height = getScreenHeight(context);

    if (isLandscape(context)) {
      // Landscape: more horizontal padding, less vertical
      return EdgeInsets.symmetric(
        horizontal: getSpacing(context, base * 1.5),
        vertical: getSpacing(context, base * 0.8),
      );
    } else {
      // Portrait: balanced padding
      return EdgeInsets.all(getSpacing(context, base));
    }
  }

  // Dynamic font sizes based on screen size
  static double getFontSize(BuildContext context, double baseSize) {
    final width = getScreenWidth(context);
    final height = getScreenHeight(context);
    final smallestDimension = width < height ? width : height;

    // Scale font based on screen size
    if (smallestDimension < 400) {
      return baseSize * 0.9; // Small screens
    } else if (smallestDimension < 600) {
      return baseSize; // Medium screens
    } else if (smallestDimension < 900) {
      return baseSize * 1.1; // Large screens
    } else {
      return baseSize * 1.2; // Extra large screens
    }
  }

  // Dynamic border radius based on screen size
  static double getBorderRadius(BuildContext context, double baseRadius) {
    final width = getScreenWidth(context);

    if (width < 400) {
      return baseRadius * 0.8; // Smaller radius for small screens
    } else if (width < 600) {
      return baseRadius; // Standard radius
    } else {
      return baseRadius * 1.2; // Larger radius for big screens
    }
  }

  // Max content width for different screen sizes
  static double getMaxContentWidth(BuildContext context) {
    final width = getScreenWidth(context);

    if (width < 600) {
      return width; // Full width for mobile
    } else if (width < 900) {
      return 600; // Tablet max width
    } else if (width < 1200) {
      return 800; // Small desktop max width
    } else {
      return 1000; // Large desktop max width
    }
  }

  // Dynamic button sizes
  static Size getButtonSize(BuildContext context, {Size? baseSize}) {
    final base = baseSize ?? const Size(200, 48);
    final width = getScreenWidth(context);

    if (width < 400) {
      return Size(base.width * 0.9, base.height * 0.9);
    } else if (width < 600) {
      return base;
    } else {
      return Size(base.width * 1.1, base.height * 1.1);
    }
  }

  // Check if device has keyboard
  static bool hasKeyboard(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom > 0;

  // Get safe area
  static EdgeInsets getSafeArea(BuildContext context) =>
      MediaQuery.of(context).padding;

  // Get available height (screen height - status bar - keyboard)
  static double getAvailableHeight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom -
        mediaQuery.viewInsets.bottom;
  }
}

// Responsive widget builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? landscape;
  final Widget? portrait;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.landscape,
    this.portrait,
  });

  @override
  Widget build(BuildContext context) {
    // Check orientation first if specified
    if (Responsive.isLandscape(context) && landscape != null) {
      return landscape!;
    } else if (Responsive.isPortrait(context) && portrait != null) {
      return portrait!;
    }

    // Then check screen size
    if (Responsive.isDesktop(context) && desktop != null) {
      return desktop!;
    } else if (Responsive.isTablet(context) && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

// Responsive value builder
class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;
  final T? landscape;
  final T? portrait;

  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.landscape,
    this.portrait,
  });

  T getValue(BuildContext context) {
    // Check orientation first if specified
    if (Responsive.isLandscape(context) && landscape != null) {
      return landscape!;
    } else if (Responsive.isPortrait(context) && portrait != null) {
      return portrait!;
    }

    // Then check screen size
    if (Responsive.isDesktop(context) && desktop != null) {
      return desktop!;
    } else if (Responsive.isTablet(context) && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
