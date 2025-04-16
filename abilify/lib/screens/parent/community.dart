import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:abilify/utils/constants.dart';
import 'package:abilify/providers/profile_provider.dart';
import 'package:abilify/widgets/custom_app_bar.dart';
import 'package:abilify/utils/mock_data.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(
        title: 'Community Events',
        actions: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(AppAssets.defaultAvatar),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover events, playgroups, therapists and support groups in the areas that matter.',
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _CategoryChip(
                      label: 'Parent Support',
                      icon: Icons.people,
                      iconColor: Colors.blue,
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    _CategoryChip(
                      label: 'Playgroups',
                      icon: Icons.toys,
                      iconColor: Colors.orange,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _CategoryChip(
                      label: 'Therapists',
                      icon: Icons.medical_services,
                      iconColor: Colors.green,
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    _CategoryChip(
                      label: 'Calendar View',
                      icon: Icons.calendar_today,
                      iconColor: Colors.purple,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              tabs: const [
                Tab(text: 'Upcoming Events'),
                Tab(text: 'Calendar View'),
                Tab(text: 'My Events'),
              ],
            ),
          ),
          
          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Upcoming Events Tab
                _UpcomingEventsTab(),
                
                // Calendar View Tab
                const Center(
                  child: Text('Calendar View Coming Soon'),
                ),
                
                // My Events Tab
                const Center(
                  child: Text('My Events Coming Soon'),
                ),
              ],
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
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
          if (index == 0) {
            Navigator.pushReplacementNamed(context, AppRoutes.parentDashboard);
          } else if (index == 2) {
            Navigator.pushNamed(context, AppRoutes.settings);
          }
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _CategoryChip({
    Key? key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (label == 'Feed') {
            Navigator.pushNamed(context, AppRoutes.parentCommunityFeed);
          } else {
            onTap();
          }
        },
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.2),
                radius: 28,
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpcomingEventsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        // Parent Support Group Event
        _EventDetailCard(
          title: 'Parent Support Group',
          dateTime: '11/15/25',
          location: 'Community Center, 123 Church Street',
          color: Colors.blue,
          icon: Icons.people,
          onTap: () {},
        ),
        const SizedBox(height: 16),
        
        // IEP Workshop Event
        _EventDetailCard(
          title: 'IEP Workshop',
          dateTime: '11/20/25',
          location: 'Virtual Meeting (Zoom)',
          color: Colors.orange,
          icon: Icons.school,
          onTap: () {},
        ),
        const SizedBox(height: 16),
        
        // Parent Support Group Event 2
        _EventDetailCard(
          title: 'Parent Support Group',
          dateTime: '12/05/25',
          location: 'Community Center, 123 Church Street',
          color: Colors.blue,
          icon: Icons.people,
          onTap: () {},
        ),
        const SizedBox(height: 16),
        
        // IEP Workshop Event 2
        _EventDetailCard(
          title: 'IEP Workshop',
          dateTime: '12/15/25',
          location: 'Virtual Meeting (Zoom)',
          color: Colors.orange,
          icon: Icons.school,
          onTap: () {},
        ),
        const SizedBox(height: 16),
        
        // Parent Support Group Event 3
        _EventDetailCard(
          title: 'Parent Support Group',
          dateTime: '01/10/26',
          location: 'Community Center, 123 Church Street',
          color: Colors.blue,
          icon: Icons.people,
          onTap: () {},
        ),
      ],
    );
  }
}

class _EventDetailCard extends StatelessWidget {
  final String title;
  final String dateTime;
  final String location;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _EventDetailCard({
    Key? key,
    required this.title,
    required this.dateTime,
    required this.location,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(AppBorderRadius.md),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.heading3,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          dateTime,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('DETAILS'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('JOIN'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                          ),
                        ),
                      ],
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