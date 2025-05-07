import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/widgets/bottom_navigation.dart';

class CommunityForum extends StatefulWidget {
  const CommunityForum({Key? key}) : super(key: key);

  @override
  _CommunityForumState createState() => _CommunityForumState();
}

class _CommunityForumState extends State<CommunityForum> {
  int _currentIndex = 2; // Set to 2 for Community tab
  int _selectedCategoryIndex = 1; // Default to "General"

  final List<Map<String, dynamic>> _categories = [
    {
      'icon': Icons.add,
      'label': 'Add',
      'color': Color(0xFFFEEBCB),
      'iconColor': Colors.black
    },
    {
      'icon': Icons.people,
      'label': 'General',
      'color': Color(0xFFD7DCBA),
      'iconColor': Colors.black
    },
    {
      'icon': Icons.event,
      'label': 'Events',
      'color': Color(0xFF8BB5E8),
      'iconColor': Colors.white
    },
    {
      'icon': Icons.brush,
      'label': 'Arts',
      'color': Color(0xFFEDCCBB),
      'iconColor': Colors.black
    },
    {
      'icon': Icons.palette,
      'label': 'Paints',
      'color': Color(0xFFD6ECF2),
      'iconColor': Colors.black
    },
  ];

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      // Navigate to the appropriate page
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/parent_home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/service_directory');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/chats');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E9), // Light cream background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Community',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'How are you feeling today?',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Search bar
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.deepPurple,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search for Session, journals.....',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Categories
                Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemExtent: 90,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: _categories[index]['color'],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _categories[index]['icon'],
                                size: 30,
                                color: _categories[index]['iconColor'],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _categories[index]['label'],
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                
                // Create post
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF1D7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFFEDCCBB),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Write something.....',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Posts
                _buildPostCard(
                  userName: 'Thomas Magnum',
                  userHandle: '@allOnBoard',
                  timePosted: '26Jun, 10:14PM',
                  content: 'You deserve a love with no trauma attached to it. A love '
                      'that is goof for your mental health, a love that is kind to '
                      'you. I\'am talking about people NOT suffering from mental '
                      'health issues.',
                  imagePath: 'assets/story_time.png',
                  likes: '55.6K',
                  comments: '32',
                  shares: '105',
                ),
                
                SizedBox(height: 16),
                
                _buildPostCard(
                  userName: 'Sarah Johnson',
                  userHandle: '@sarahJ',
                  timePosted: '25Jun, 3:45PM',
                  content: 'Just had a breakthrough with my son today during therapy. '
                      'The techniques we\'ve been using are finally showing results! '
                      'So grateful for this community and all the support.',
                  imagePath: null,
                  likes: '124',
                  comments: '18',
                  shares: '5',
                ),
                
                SizedBox(height: 80), // Bottom space for navigation bar
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AbilifyBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
  
  Widget _buildPostCard({
    required String userName,
    required String userHandle,
    required String timePosted,
    required String content,
    String? imagePath,
    required String likes,
    required String comments,
    required String shares,
  }) {
    return Container(
      width: double.infinity,
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
          // Post header with profile pic and name
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFFD7DCBA),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '$userHandle $timePosted',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_vert,
                color: Colors.black54,
              ),
            ],
          ),
          
          // Post content
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              content,
              style: GoogleFonts.poppins(
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ),
          
          // Post image if available
          if (imagePath != null)
            Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade200,
              ),
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          
          // Post actions
          Row(
            children: [
              Icon(Icons.chat_bubble_outline, color: Colors.black54),
              SizedBox(width: 4),
              Text(
                comments,
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 24),
              Icon(Icons.favorite_border, color: Colors.black54),
              SizedBox(width: 4),
              Text(
                likes,
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 24),
              Icon(Icons.reply, color: Colors.black54),
              SizedBox(width: 4),
              Text(
                shares,
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 