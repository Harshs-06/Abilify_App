import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:abilify/utils/constants.dart';
import 'package:abilify/providers/profile_provider.dart';
import 'package:abilify/widgets/custom_button.dart';

class ProfileSelectionScreen extends StatelessWidget {
  const ProfileSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7E4), // Light cream background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              
              // Logo and App Name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'abilify',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 24,
                  ),
                ],
              ),
              
              const SizedBox(height: 5),
              
              // Tagline
              Text(
                kAppTagline,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              
              const SizedBox(height: 60),
              
              // Continue As Text
              Text(
                'CONTINUE AS',
                style: AppTextStyles.heading3.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Profile Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Palak Profile
                  _ProfileAvatar(
                    name: 'Palak',
                    onTap: () {
                      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
                      profileProvider.setCurrentProfileType(ProfileType.parent);
                      Navigator.pushReplacementNamed(context, AppRoutes.parentDashboard);
                    },
                    avatarColor: AppColors.primary,
                  ),
                  
                  const SizedBox(width: 40),
                  
                  // Jade Profile
                  _ProfileAvatar(
                    name: 'Jade',
                    onTap: () {
                      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
                      profileProvider.setCurrentProfileType(ProfileType.child);
                      Navigator.pushReplacementNamed(context, AppRoutes.childDashboard);
                    },
                    avatarColor: Colors.redAccent,
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Add New Profile Button
              ChildCustomButton(
                text: 'Add New Profile',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                icon: Icons.add,
                backgroundColor: AppColors.primary,
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final Color avatarColor;
  
  const _ProfileAvatar({
    Key? key,
    required this.name,
    required this.onTap,
    required this.avatarColor,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar Circle
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: avatarColor,
            ),
            child: Center(
              child: Icon(
                name == 'Palak' ? Icons.face_5 : Icons.face_6,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Profile Name
        Text(
          name,
          style: AppTextStyles.heading3,
        ),
      ],
    );
  }
} 