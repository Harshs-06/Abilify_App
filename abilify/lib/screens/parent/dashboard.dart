import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:abilify/utils/constants.dart';
import 'package:abilify/providers/profile_provider.dart';
import 'package:abilify/widgets/custom_app_bar.dart';
import 'package:abilify/utils/mock_data.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({Key? key}) : super(key: key);

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  // Selected emotion index
  int _selectedEmotionIndex = -1;
  
  // List of emotions
  final List<Map<String, dynamic>> _emotions = [
    {'emoji': '😊', 'name': 'Happy'},
    {'emoji': '😔', 'name': 'Sad'},
    {'emoji': '😡', 'name': 'Angry'},
  ];

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final parentProfile = profileProvider.parentProfile;
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Parent_Home_page',
          style: AppTextStyles.heading3,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Section
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Hi, ${parentProfile.name.split(' ').first}!',
                        style: AppTextStyles.heading2,
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('assets/images/default_avatar.png'),
                      ),
                    ],
                  ),
                  Text(
                    'How are you doing today?',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.mic),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppBorderRadius.md),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.sm,
                  ),
                ),
              ),
            ),
            
            // How are you feeling today
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How are you feeling today?',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      _emotions.length,
                      (index) => _EmotionButton(
                        emoji: _emotions[index]['emoji'],
                        isSelected: _selectedEmotionIndex == index,
                        onTap: () {
                          setState(() {
                            _selectedEmotionIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Quick Actions
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _QuickActionButton(
                        icon: Icons.calendar_today,
                        title: 'Calendar',
                        onTap: () {
                          // Navigate to calendar
                        },
                      ),
                      _QuickActionButton(
                        icon: Icons.people_alt_outlined,
                        title: 'Find & Join Parents',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.parentCommunity);
                        },
                      ),
                      _QuickActionButton(
                        icon: Icons.show_chart,
                        title: 'Progress Tracking',
                        onTap: () {
                          // Navigate to progress tracking
                        },
                      ),
                      _QuickActionButton(
                        icon: Icons.favorite_border,
                        title: 'Buddy Program',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.parentBuddyProgram);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Upcoming Events
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Events',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _EventCard(
                    title: 'Parent Support Group',
                    dateTime: '11/15/25 @ Community Center, 123 Church Street',
                    color: Colors.blue,
                    icon: Icons.people,
                    onTap: () {
                      // Navigate to event details
                    },
                  ),
                  const SizedBox(height: 12),
                  _EventCard(
                    title: 'IEP Workshop',
                    dateTime: '11/20/25 @ Virtual Meeting (Zoom)',
                    color: Colors.orange,
                    icon: Icons.school,
                    onTap: () {
                      // Navigate to event details
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
        ],
        onTap: (index) {
          // Handle navigation
          if (index == 1) {
            Navigator.pushNamed(context, AppRoutes.parentResources);
          } else if (index == 2) {
            Navigator.pushNamed(context, AppRoutes.settings);
          } else if (index == 3) {
            Navigator.pushNamed(context, AppRoutes.parentCommunityFeed);
          }
        },
      ),
    );
  }
}

class _EmotionButton extends StatelessWidget {
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const _EmotionButton({
    Key? key,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withOpacity(0.2) : Colors.white,
            borderRadius: BorderRadius.circular(AppBorderRadius.md),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickActionButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppBorderRadius.md),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppBorderRadius.md),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 80,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final String title;
  final String dateTime;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _EventCard({
    Key? key,
    required this.title,
    required this.dateTime,
    required this.color,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.md),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppBorderRadius.md),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(AppBorderRadius.md),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateTime,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
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