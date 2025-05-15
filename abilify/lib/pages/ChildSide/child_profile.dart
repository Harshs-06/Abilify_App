import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:abilify/pages/sign_up.dart';
import 'package:abilify/pages/login.dart';
import 'package:abilify/pages/ChildSide/edit_profile.dart';
import 'package:abilify/pages/ChildSide/notification_preferences.dart';
import 'package:abilify/pages/ChildSide/parent_controls.dart';
import 'package:abilify/pages/ParentSide/parent_home_page.dart';
import 'package:abilify/services/user_data_provider.dart';
import 'package:abilify/services/auth_service.dart';

class ChildProfile extends StatefulWidget {
  const ChildProfile({super.key});

  @override
  State<ChildProfile> createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildProfile> {
  late String childName;
  late String childAge;
  late String profileImage;
  late bool isAssetImage;
  final UserDataProvider _userDataProvider = UserDataProvider();
  final AuthService _authService = AuthService();
  
  @override
  void initState() {
    super.initState();
    loadUserData();
  }
  
  void loadUserData() {
    // Get name from auth service, fallback to user data provider
    childName = _authService.currentUser?.displayName ?? _userDataProvider.childName;
    childAge = _userDataProvider.childAge;
    profileImage = _userDataProvider.profileImage;
    isAssetImage = _userDataProvider.isAssetImage;
  }
  
  Future<void> _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfile(
          initialName: childName,
          initialAge: childAge,
          profileImage: profileImage,
        ),
      ),
    );
    
    if (result != null) {
      setState(() {
        loadUserData(); // Reload all data from services
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with gradient background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.amber.shade300,
                      Color.fromARGB(255, 251, 239, 215),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.only(top: 16, bottom: 30, left: 16, right: 16),
                child: Column(
                  children: [
                    // App bar with back button
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 24.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'My Profile',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 30),
                    
                    // Profile picture and name
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.amber,
                                width: 4.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: isAssetImage
                                ? Image.asset(
                                    profileImage,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(profileImage),
                                    fit: BoxFit.cover,
                                  ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            childName,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Explorer Level 3 • Age $childAge',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Statistics section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bar_chart, color: Colors.deepPurple),
                        SizedBox(width: 8),
                        Text(
                          'My Progress',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Statistics cards in a row
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Stories',
                            value: '5',
                            iconData: Icons.menu_book,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            title: 'Songs',
                            value: '7',
                            iconData: Icons.music_note,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            title: 'Games',
                            value: '3',
                            iconData: Icons.games,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Achievements section
                    Row(
                      children: [
                        Icon(Icons.emoji_events, color: Colors.amber),
                        SizedBox(width: 8),
                        Text(
                          'My Achievements',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Achievements list
                    AchievementCard(
                      title: 'Story Explorer',
                      description: 'Read 5 different stories',
                      isCompleted: true,
                      progress: 1.0,
                    ),
                    
                    SizedBox(height: 12),
                    
                    AchievementCard(
                      title: 'Music Enthusiast',
                      description: 'Listen to 10 different songs',
                      isCompleted: false,
                      progress: 0.7,
                    ),
                    
                    SizedBox(height: 12),
                    
                    AchievementCard(
                      title: 'Star Collector',
                      description: 'Collect 50 stars in total',
                      isCompleted: false,
                      progress: 0.5,
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Settings section
                    Row(
                      children: [
                        Icon(Icons.settings, color: Colors.grey.shade700),
                        SizedBox(width: 8),
                        Text(
                          'Settings',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Settings list
                    SettingItem(
                      title: 'Edit Profile',
                      iconData: Icons.edit,
                      onTap: _navigateToEditProfile,
                    ),
                    
                    SettingItem(
                      title: 'Notification Preferences',
                      iconData: Icons.notifications,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationPreferences()),
                        );
                      },
                    ),
                    
                    SettingItem(
                      title: 'Parent Controls',
                      iconData: Icons.family_restroom,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ParentControls()),
                        );
                      },
                    ),
                    
                    SettingItem(
                      title: 'Switch to Parent Mode',
                      iconData: Icons.swap_horiz,
                      backgroundColor: Colors.purple.shade50,
                      iconColor: Color(0xFF9471E1),
                      textColor: Color(0xFF9471E1),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ParentHomePage()),
                        );
                      },
                    ),
                    
                    SettingItem(
                      title: 'Sign Out',
                      iconData: Icons.logout,
                      backgroundColor: Colors.red.shade50,
                      iconColor: Colors.red.shade700,
                      textColor: Colors.red.shade800,
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Login()),
                          (route) => false,
                        );
                      },
                    ),
                    
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Stat Card Widget
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconData;
  final Color color;

  const StatCard({super.key, 
    required this.title,
    required this.value,
    required this.iconData,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// Achievement Card Widget
class AchievementCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isCompleted;
  final double progress;

  const AchievementCard({super.key, 
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isCompleted ? Colors.amber.withOpacity(0.1) : Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCompleted ? Icons.emoji_events : Icons.emoji_events_outlined,
                  color: isCompleted ? Colors.amber : Colors.grey,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (isCompleted)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Completed',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12),
          LinearPercentIndicator(
            lineHeight: 10,
            percent: progress,
            backgroundColor: Colors.grey.shade200,
            progressColor: isCompleted ? Colors.green : Colors.amber,
            barRadius: const Radius.circular(10),
            padding: EdgeInsets.zero,
            animation: true,
            animationDuration: 4000,
          ),
        ],
      ),
    );
  }
}

// Setting Item Widget
class SettingItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function() onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;

  const SettingItem({super.key, 
    required this.title,
    required this.iconData,
    required this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: backgroundColor != null ? backgroundColor!.withOpacity(0.2) : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: iconColor ?? Colors.grey.shade700,
                size: 20,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
} 