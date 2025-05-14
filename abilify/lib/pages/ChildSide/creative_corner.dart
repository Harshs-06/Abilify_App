import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:abilify/services/local_data_service.dart';
import 'package:provider/provider.dart';

class CreativeCorner extends StatefulWidget {
  const CreativeCorner({super.key});

  @override
  State<CreativeCorner> createState() => _CreativeCornerState();
}

class _CreativeCornerState extends State<CreativeCorner> {
  int _selectedCategoryIndex = 0;
  final TextEditingController _postController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  
  // Posts will be loaded from LocalDataService
  List<Map<String, dynamic>> _posts = [];
  
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

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() async {
    setState(() {
      _isLoading = true;
    });
    
    // Get the LocalDataService instance
    final LocalDataService dataService = Provider.of<LocalDataService>(context, listen: false);
    
    try {
      // Load creative corner posts
      await dataService.init();
      setState(() {
        _posts = dataService.creativeCornerPosts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading artwork: $e')),
      );
    }
  }

  void _showAddPostDialog() {
    File? selectedImageFile;
    
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
                    if (_postController.text.isNotEmpty && selectedImageFile != null) {
                      _addNewPost(_postController.text, selectedImageFile!);
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
  
  void _addNewPost(String content, File imageFile) async {
    setState(() {
      _isLoading = true;
    });
    
    // Get the LocalDataService instance
    final LocalDataService dataService = Provider.of<LocalDataService>(context, listen: false);
    
    try {
      // Add the post to local storage
      await dataService.addCreativeCornerPost(content, imageFile);
      
      // Refresh the posts list
      setState(() {
        _posts = dataService.creativeCornerPosts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding artwork: $e'),
          backgroundColor: Colors.red.shade300,
        ),
      );
    }
  }
  
  void _toggleLike(int index) async {
    // Get the LocalDataService instance
    final LocalDataService dataService = Provider.of<LocalDataService>(context, listen: false);
    
    try {
      // Toggle like in local storage
      await dataService.toggleCreativeCornerPostLike(_posts[index]['id']);
      
      // Refresh the posts list
      setState(() {
        _posts = dataService.creativeCornerPosts;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error liking artwork: $e'),
          backgroundColor: Colors.red.shade300,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade400,
              ),
            )
          : SingleChildScrollView(
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
                          radius: 20,
                          backgroundColor: Colors.orange.shade200,
                          child: Icon(
                            Icons.brush,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Share your artwork here...',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Colors.blue.shade300,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Posts grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Recent Artwork',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      
                      _posts.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 50.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.brush,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'No artwork yet',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Be the first to share your creative artwork!',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                            itemCount: _posts.length,
                            itemBuilder: (context, index) {
                              final post = _posts[index];
                              return _buildArtworkCard(
                                index: index,
                                childName: post['childName'],
                                timePosted: post['timePosted'],
                                content: post['content'],
                                imagePath: post['imagePath'],
                                isAsset: post['isAsset'] ?? false,
                                likes: post['likes'],
                                likedByMe: post['likedByMe'],
                                comments: post['comments'],
                              );
                            },
                          ),
                      
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }

  Widget _buildArtworkCard({
    required int index,
    required String childName,
    required String timePosted,
    required String content,
    required String imagePath,
    required bool isAsset,
    required int likes,
    required bool likedByMe,
    required int comments,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Artwork image
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  isAsset
                    ? Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                      ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                        Icons.favorite,
                        color: Colors.red.shade300,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Post info
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        childName,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        timePosted.contains("Just now") ? "New!" : "",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    content,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => _toggleLike(index),
                        child: Row(
                          children: [
                            Icon(
                              likedByMe ? Icons.favorite : Icons.favorite_border,
                              color: likedByMe ? Colors.red : Colors.grey.shade600,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              likes.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.grey.shade600,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            comments.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 