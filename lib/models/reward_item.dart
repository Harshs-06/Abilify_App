class RewardItem {
  final String id;
  final String name;
  final String description;
  final int points;
  final String imagePath;
  final String category;
  
  RewardItem({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.imagePath,
    required this.category,
  });
  
  static List<RewardItem> getRewardItems() {
    return [
      // Toys category
      RewardItem(
        id: 'toy_1',
        name: 'Fidget Spinner',
        description: 'A colorful fidget spinner to help with focus and calm',
        points: 25,
        imagePath: 'assets/story_time.png',
        category: 'Toys',
      ),
      RewardItem(
        id: 'toy_2',
        name: 'Plush Animal',
        description: 'A cute and soft plush animal companion',
        points: 50,
        imagePath: 'assets/story_time.png',
        category: 'Toys',
      ),
      RewardItem(
        id: 'toy_3',
        name: 'Building Blocks Set',
        description: 'Creative building blocks to enhance cognitive skills',
        points: 75,
        imagePath: 'assets/story_time.png',
        category: 'Toys',
      ),
      
      // Digital Rewards
      RewardItem(
        id: 'digital_1',
        name: 'New App Theme',
        description: 'Customize app with special color theme',
        points: 40,
        imagePath: 'assets/story_time.png',
        category: 'Digital',
      ),
      RewardItem(
        id: 'digital_2',
        name: 'Avatar Accessories',
        description: 'Special accessories for your profile avatar',
        points: 30,
        imagePath: 'assets/story_time.png',
        category: 'Digital',
      ),
      RewardItem(
        id: 'digital_3',
        name: 'Bonus Game Access',
        description: 'Access special bonus games for one week',
        points: 60,
        imagePath: 'assets/story_time.png',
        category: 'Digital',
      ),
      
      // Real-world Rewards
      RewardItem(
        id: 'real_1',
        name: 'Extra Screen Time',
        description: '30 minutes of extra screen time',
        points: 45,
        imagePath: 'assets/story_time.png',
        category: 'Activities',
      ),
      RewardItem(
        id: 'real_2',
        name: 'Special Treat',
        description: 'A special treat of your choice',
        points: 35,
        imagePath: 'assets/story_time.png',
        category: 'Activities',
      ),
      RewardItem(
        id: 'real_3',
        name: 'Outing Choice',
        description: 'Choose a special place to visit this weekend',
        points: 100,
        imagePath: 'assets/story_time.png',
        category: 'Activities',
      ),
    ];
  }
  
  // Get items by category
  static List<RewardItem> getItemsByCategory(String category) {
    return getRewardItems().where((item) => item.category == category).toList();
  }
  
  // Get all categories
  static List<String> getCategories() {
    return ['All', 'Toys', 'Digital', 'Activities'];
  }
} 