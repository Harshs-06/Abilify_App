import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:abilify/utils/constants.dart';
import 'package:abilify/providers/profile_provider.dart';
import 'package:abilify/widgets/custom_app_bar.dart';
import 'package:abilify/utils/mock_data.dart';

class CommunityFeedScreen extends StatefulWidget {
  const CommunityFeedScreen({Key? key}) : super(key: key);

  @override
  State<CommunityFeedScreen> createState() => _CommunityFeedScreenState();
}

class _CommunityFeedScreenState extends State<CommunityFeedScreen> {
  final TextEditingController _postController = TextEditingController();
  int _selectedCategoryIndex = 0;
  
  final List<Map<String, dynamic>> _categories = [
    {'name': 'General', 'color': Colors.grey[400]},
    {'name': 'Events', 'color': Colors.blue[300]},
    {'name': 'Arts', 'color': Colors.purple[300]},
    {'name': 'Parents', 'color': Colors.orange[300]},
  ];
  
  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(
        title: 'Community',
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
        children: [
          // Header with "How are you feeling today?"
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How are you feeling today?',
                  style: AppTextStyles.heading3,
                ),
                const SizedBox(height: 16),
                
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for Session journals...',
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.md),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Categories Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Add button
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.add, size: 18),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                    ),
                    
                    // Category Buttons
                    ...List.generate(
                      _categories.length,
                      (index) => _CategoryButton(
                        label: _categories[index]['name'],
                        color: _categories[index]['color'],
                        isSelected: _selectedCategoryIndex == index,
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Post creation field
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(AppBorderRadius.md),
                  ),
                  child: TextField(
                    controller: _postController,
                    decoration: const InputDecoration(
                      hintText: 'Write something...',
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                    minLines: 1,
                  ),
                ),
              ],
            ),
          ),
          
          // Posts List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                _PostCard(
                  author: 'Thomas Magnum',
                  timestamp: 'Posted 2 hours ago • 01:45PM',
                  content: 'You deserve a box with no trauma attached to it. A nice big box, and you can arrange maybe 4 or 5 treasures inside it. Your life is out of control? Not this box! You can talking about people NOT suffering from mental health issues.',
                  likes: 32,
                  comments: 5,
                  onLike: () {},
                  onComment: () {},
                  onShare: () {},
                ),
                
                const SizedBox(height: 16),
                
                // Add more post cards here
              ],
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
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
          } else if (index == 1) {
            Navigator.pushNamed(context, AppRoutes.parentResources);
          } else if (index == 2) {
            Navigator.pushNamed(context, AppRoutes.settings);
          } else if (index == 3 && ModalRoute.of(context)?.settings.name != AppRoutes.parentCommunityFeed) {
            Navigator.pushNamed(context, AppRoutes.parentCommunityFeed);
          }
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final String label;
  final Color? color;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryButton({
    Key? key,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppBorderRadius.lg),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey[200],
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final String author;
  final String timestamp;
  final String content;
  final int likes;
  final int comments;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const _PostCard({
    Key? key,
    required this.author,
    required this.timestamp,
    required this.content,
    required this.likes,
    required this.comments,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Header - Author and Timestamp
            Row(
              children: [
                // Author Avatar
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    'TM',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Author and Timestamp
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        timestamp,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Menu Button
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Post Content
            Text(
              content,
              style: AppTextStyles.bodyMedium,
            ),
            
            const SizedBox(height: 16),
            
            // Post Image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppBorderRadius.md),
              child: Image.asset(
                'assets/images/mental_health_post.png', // This is a placeholder, replace with your image
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 48,
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Interaction Counters
            Row(
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '$likes likes',
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.chat_bubble_outline,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '$comments comments',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
            
            const Divider(height: 24),
            
            // Interaction Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _InteractionButton(
                  icon: Icons.favorite_border,
                  label: 'Like',
                  onTap: onLike,
                ),
                _InteractionButton(
                  icon: Icons.chat_bubble_outline,
                  label: 'Comment',
                  onTap: onComment,
                ),
                _InteractionButton(
                  icon: Icons.share,
                  label: 'Share',
                  onTap: onShare,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InteractionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _InteractionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.md,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
