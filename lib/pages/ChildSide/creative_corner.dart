import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreativeCorner extends StatefulWidget {
  const CreativeCorner({super.key});

  @override
  State<CreativeCorner> createState() => _CreativeCornerState();
}

class _CreativeCornerState extends State<CreativeCorner> {
  int _selectedCategoryIndex = 0;
  final TextEditingController _postController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  
  // Posts data with mutable likes and comments
  List<Map<String, dynamic>> _posts = [
    {
      'childName': 'Jade',
      'timePosted': 'Today, 2:30 PM',
      'content': 'I drew this picture of my family at the park!',
      'imagePath': 'assets/story_time.png',
      'isAsset': true,
      'likes': 15,
      'likedByMe': false,
      'comments': 4,
    },
    {
      'childName': 'Sammy',
      'timePosted': 'Yesterday, 5:15 PM',
      'content': 'My clay animal collection I made in art class!',
      'imagePath': 'assets/story_time.png',
      'isAsset': true,
      'likes': 23,
      'likedByMe': false,
      'comments': 7,
    },
    {
      'childName': 'Leo',
      'timePosted': 'Monday, 4:45 PM',
      'content': 'My favorite drawing of the week - space adventure!',
      'imagePath': 'assets/story_time.png',
      'isAsset': true,
      'likes': 32,
      'likedByMe': false,
      'comments': 12,
    },
  ];
  
  final List<Map<String, dynamic>> _categories = [
    {
      'icon': Icons.add,
      'label': 'Add',
      'color': Color(0xFFFEEBCB),
    },
    {
      'icon': Icons.star,
      'label': 'Popular',
      'color': Color(0xFFFFD166),
    },
    {
      'icon': Icons.event,
      'label': 'Events',
      'color': Color(0xFF8BB5E8),
    },
    {
      'icon': Icons.brush,
      'label': 'Arts',
      'color': Color(0xFFEDCCBB),
    },
    {
      'icon': Icons.palette,
      'label': 'Paints',
      'color': Color(0xFFAA7EFF),
    },
  ];

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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                'Share Your Art',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _postController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Tell us about your artwork...',
                        hintStyle: GoogleFonts.poppins(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue.shade100),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Add Art:',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue.shade700,
                          ),
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
                                SnackBar(
                                  content: Text('Oops! Something went wrong picking your image.'),
                                  backgroundColor: Colors.red.shade300,
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.image, color: Colors.white),
                          label: Text(
                            'Choose Picture',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (selectedImageFile != null) ...[
                      SizedBox(height: 16),
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.blue.shade100, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
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
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_postController.text.isNotEmpty && selectedImagePath != null) {
                      _addNewPost(_postController.text, selectedImagePath, isAsset);
                      Navigator.of(context).pop();
                      _postController.clear();
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Your artwork was shared! 🎨'),
                          backgroundColor: Colors.green.shade400,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please add both text and an image'),
                          backgroundColor: Colors.amber.shade400,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Share',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
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
        'childName': 'Me',
        'timePosted': 'Just now',
        'content': content,
        'imagePath': imagePath,
        'isAsset': isAsset,
        'likes': 0,
        'likedByMe': false,
        'comments': 0,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header section with gradient background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.shade300,
                      Color.fromARGB(255, 251, 239, 215),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.only(top: 16, bottom: 25),
                child: Column(
                  children: [
                    // App bar with back button and title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
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
                          SizedBox(width: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.brush,
                                color: Colors.blue[600],
                                size: 28,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Creative Corner',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Share your creations with friends!',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(10),
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
                            child: Icon(
                              Icons.palette,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Search bar
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
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
                          Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for drawings, crafts...',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 16),
              
              // Categories
              Container(
                height: 115,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemExtent: 85,
                  padding: EdgeInsets.symmetric(horizontal: 10),
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: _categories[index]['color'],
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              _categories[index]['icon'],
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            _categories[index]['label'],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              // Create post area
              GestureDetector(
                onTap: _showAddPostDialog,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.amber.shade200,
                        child: Icon(
                          Icons.person,
                          color: Colors.amber.shade800,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Share your artwork...',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Posts
              for (int i = 0; i < _posts.length; i++) ...[
                _buildCreativePost(
                  index: i,
                  childName: _posts[i]['childName'],
                  timePosted: _posts[i]['timePosted'],
                  content: _posts[i]['content'],
                  imagePath: _posts[i]['imagePath'],
                  isAsset: _posts[i]['isAsset'],
                  likes: _posts[i]['likes'],
                  comments: _posts[i]['comments'],
                  isLiked: _posts[i]['likedByMe'],
                ),
                SizedBox(height: 12),
              ],
              
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildCreativePost({
    required int index,
    required String childName,
    required String timePosted,
    required String content,
    required String imagePath,
    required bool isAsset,
    required int likes,
    required int comments,
    required bool isLiked,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.amber.shade200,
                  child: Text(
                    childName[0],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.amber.shade800,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        childName,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        timePosted,
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          
          // Caption
          if (content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                content,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ),
            
          SizedBox(height: 12),
          
          // Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: isAsset 
              ? Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(imagePath),
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                ),
          ),
          
          // Actions
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _toggleLike(index),
                  child: Row(
                    children: [
                      Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.red.shade300,
                        size: 22,
                      ),
                      SizedBox(width: 4),
                      Text(
                        likes.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isLiked ? Colors.red : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 24),
                Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.blue,
                      size: 22,
                    ),
                    SizedBox(width: 4),
                    Text(
                      comments.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Great work!',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 