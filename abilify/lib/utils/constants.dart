import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// App name
const String kAppName = 'Abilify';
const String kAppTagline = 'Because every kid deserves support';

// API Keys and External URLs (if needed)
// const String kApiKey = 'your-api-key';

// Storage Keys
const String kParentProfileKey = 'parent_profile';
const String kChildProfileKey = 'child_profile';
const String kResourcesKey = 'resources';
const String kCurrentProfileTypeKey = 'current_profile_type';

// Profile Types
enum ProfileType { parent, child }

// Colors
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF2196F3); // Blue
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1976D2);
  
  // Accent colors
  static const Color accent = Color(0xFFFF9800); // Orange
  static const Color accentLight = Color(0xFFFFB74D);
  static const Color accentDark = Color(0xFFF57C00);
  
  // Background colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Colors.white;
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFEB3B);
  static const Color info = Color(0xFF2196F3);

  // Category colors
  static const Color sensory = Color(0xFFE57373);
  static const Color speech = Color(0xFF81C784);
  static const Color occupational = Color(0xFF64B5F6);
  static const Color behavioral = Color(0xFFBA68C8);
  static const Color educational = Color(0xFFFFD54F);
  static const Color parenting = Color(0xFF4DB6AC);
  
  // Child profile colors
  static const List<Color> childColors = [
    Color(0xFFFF5252),  // Red
    Color(0xFF448AFF),  // Blue
    Color(0xFF66BB6A),  // Green
    Color(0xFFFFD740),  // Amber
    Color(0xFFE040FB),  // Purple
    Color(0xFF40C4FF),  // Light Blue
  ];
  
  // Badge colors
  static const Color badgeBackground = Color(0xFFFFF9C4);
  static const Color badgeBorder = Color(0xFFFFEB3B);
}

// Text Styles
class AppTextStyles {
  static TextStyle get heading1 => GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get heading2 => GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get heading3 => GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get bodyLarge => GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get bodyMedium => GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get bodySmall => GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  static TextStyle get button => GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textLight,
  );
  
  // Child-friendly text styles
  static TextStyle get childHeading => GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get childBody => GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get childButton => GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );
}

// Spacing
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

// Border Radiuses
class AppBorderRadius {
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const Radius radiusSm = Radius.circular(sm);
  static const Radius radiusMd = Radius.circular(md);
  static const Radius radiusLg = Radius.circular(lg);
  static const Radius radiusXl = Radius.circular(xl);
}

// Durations
class AppDurations {
  static const Duration shortest = Duration(milliseconds: 150);
  static const Duration short = Duration(milliseconds: 250);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration long = Duration(milliseconds: 500);
}

// Navigation Routes
class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String parentDashboard = '/parent/dashboard';
  static const String childDashboard = '/child/dashboard';
  static const String settings = '/settings';
  static const String parentCommunity = '/parent/community';
  static const String parentCommunityFeed = '/parent/community-feed';
  static const String parentResources = '/parent/resources';
  static const String parentBuddyProgram = '/parent/buddy-program';
  static const String childActivities = '/child/activities';
  static const String childRewards = '/child/rewards';
  static const String activityColoring = '/child/activities/coloring';
  static const String activityMemory = '/child/activities/memory';
  static const String activityMusic = '/child/activities/music';
}

// Asset Paths
class AppAssets {
  static const String imagesPath = 'assets/images/';
  static const String audioPath = 'assets/audio/';
  static const String dataPath = 'assets/data/';
  
  // Images
  static const String logoImage = '${imagesPath}logo.png';
  static const String onboardingImage1 = '${imagesPath}onboarding1.png';
  static const String onboardingImage2 = '${imagesPath}onboarding2.png';
  static const String onboardingImage3 = '${imagesPath}onboarding3.png';
  static const String defaultAvatar = '${imagesPath}default_avatar.png';
  static const String starBadge = '${imagesPath}badge_star.png';
  static const String helperBadge = '${imagesPath}badge_helper.png';
  
  // Audio
  static const String calmingMusic1 = '${audioPath}calming_music_1.mp3';
  static const String calmingMusic2 = '${audioPath}calming_music_2.mp3';
  static const String successSound = '${audioPath}success.mp3';
  
  // Data files
  static const String resourcesData = '${dataPath}resources.json';
  static const String forumData = '${dataPath}forum.json';
  static const String buddiesData = '${dataPath}buddies.json';
} 