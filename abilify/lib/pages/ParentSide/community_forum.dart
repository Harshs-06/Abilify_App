import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/widgets/bottom_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CommunityForum extends StatefulWidget {
  const CommunityForum({Key? key}) : super(key: key);

  @override
  _CommunityForumState createState() => _CommunityForumState();
}

class _CommunityForumState extends State<CommunityForum> {
  int _currentIndex = 2; // Set to 2 for Community tab
  int _selectedCategoryIndex = 1; // Default to "General"
  final TextEditingController _postController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  
  // Posts data with mutable likes and comments
  List<Map<String, dynamic>> _posts = [
    {
      'userName': 'Thomas Magnum',
      'userHandle': '@allOnBoard',
      'timePosted': '26Jun, 10:14PM',
      'content': 'You deserve a love with no trauma attached to it. A love '
          'that is goof for your mental health, a love that is kind to '
          'you. I\'am talking about people NOT suffering from mental '
          'health issues.',
      'imagePath': 'assets/story_time.png',
      'isAsset': true,
      'likes': 55600,
      'likedByMe': false,
      'comments': [
        {'text': 'This is so meaningful, thank you!', 'author': 'Jane D.'},
        {'text': 'Needed to hear this today ❤️', 'author': 'Michael S.'},
      ],
    },
    {
      'userName': 'Sarah Johnson',
      'userHandle': '@sarahJ',
      'timePosted': '25Jun, 3:45PM',
      'content': 'Just had a breakthrough with my son today during therapy. '
          'The techniques we\'ve been using are finally showing results! '
          'So grateful for this community and all the support.',
      'imagePath': null,
      'isAsset': true,
      'likes': 124,
      'likedByMe': false,
      'comments': [
        {'text': 'That\'s amazing news!', 'author': 'Mark H.'},
        {'text': 'So happy for you both!', 'author': 'Lisa P.'},
      ],
    },
  ];

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

  @override
  void dispose() {
    _postController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _showAddPostDialog() {
    String? selectedImagePath;
    File? selectedImageFile;
    bool isAsset = true;
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Create Post',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _postController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'What\'s on your mind?',
                        hintStyle: GoogleFonts.poppins(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Add Image:',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 80,
                              );
                              
                              if (image != null) {
                                setState(() {
                                  selectedImageFile = File(image.path);
                                  selectedImagePath = image.path;
                                  isAsset = false;
                                });
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error picking image: $e')),
                              );
                            }
                          },
                          icon: Icon(Icons.image),
                          label: Text('Select'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                    if (selectedImageFile != null) ...[
                      SizedBox(height: 12),
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            selectedImageFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _postController.clear();
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(color: Colors.grey[700]),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_postController.text.isNotEmpty) {
                      setState(() {
                        _addNewPost(_postController.text, selectedImagePath, isAsset);
                      });
                      Navigator.of(context).pop();
                      _postController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9471E1),
                  ),
                  child: Text(
                    'Post',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ],
            );
          }
        );
      },
    );
  }
  
  void _addNewPost(String content, String? imagePath, bool isAsset) {
    setState(() {
      _posts.insert(0, {
        'userName': 'Me',
        'userHandle': '@parent',
        'timePosted': 'Just now',
        'content': content,
        'imagePath': imagePath,
        'isAsset': isAsset,
        'likes': 0,
        'likedByMe': false,
        'comments': [],
      });
    });
  }
  
  void _toggleLike(int index) {
    setState(() {
      if (_posts[index]['likedByMe']) {
        _posts[index]['likes'] = _posts[index]['likes'] - 1;
      } else {
        _posts[index]['likes'] = _posts[index]['likes'] + 1;
      }
      _posts[index]['likedByMe'] = !_posts[index]['likedByMe'];
    });
  }
  
  void _showAddCommentDialog(int postIndex) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Add Comment',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Write a comment...',
              hintStyle: GoogleFonts.poppins(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _commentController.clear();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(color: Colors.grey[700]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  setState(() {
                    _posts[postIndex]['comments'].add({
                      'text': _commentController.text,
                      'author': 'Me',
                    });
                  });
                  Navigator.of(context).pop();
                  _commentController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9471E1),
              ),
              child: Text(
                'Comment',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

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
                          
                          // Handle Add button tap
                          if (index == 0) {
                            _showAddPostDialog();
                          }
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
                GestureDetector(
                  onTap: _showAddPostDialog,
                  child: Container(
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
                ),
                
                // Posts
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    final likeCount = post['likes'];
                    final String likesText = likeCount >= 1000 
                        ? '${(likeCount / 1000).toStringAsFixed(1)}K'
                        : likeCount.toString();
                    
                    return Column(
                      children: [
                        _buildPostCard(
                          index: index,
                          userName: post['userName'],
                          userHandle: post['userHandle'],
                          timePosted: post['timePosted'],
                          content: post['content'],
                          imagePath: post['imagePath'],
                          likes: likesText,
                          comments: post['comments'].length.toString(),
                          shares: '105',
                          isLiked: post['likedByMe'],
                        ),
                        SizedBox(height: 16),
                      ],
                    );
                  },
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
    required int index,
    required String userName,
    required String userHandle,
    required String timePosted,
    required String content,
    String? imagePath,
    required String likes,
    required String comments,
    required String shares,
    required bool isLiked,
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
                child: _posts[index]['isAsset'] == true
                  ? Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
              ),
            ),
          
          // Post actions
          Row(
            children: [
              InkWell(
                onTap: () => _showAddCommentDialog(index),
                child: Row(
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
                  ],
                ),
              ),
              SizedBox(width: 24),
              InkWell(
                onTap: () => _toggleLike(index),
                child: Row(
                  children: [
                    Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.black54,
                    ),
                    SizedBox(width: 4),
                    Text(
                      likes,
                      style: GoogleFonts.poppins(
                        color: isLiked ? Colors.red : Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 24),
              Row(
                children: [
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
          
          // Show comments if there are any
          if (_posts[index]['comments'].length > 0) ...[
            SizedBox(height: 16),
            Divider(),
            ..._posts[index]['comments'].map((comment) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Color(0xFFEDCCBB),
                      child: Text(
                        comment['author'][0],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment['author'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            comment['text'],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }
} 