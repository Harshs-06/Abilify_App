import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/models/friend_request_model.dart';
import 'package:abilify/models/chat_model.dart';
import 'package:intl/intl.dart';
import 'package:abilify/pages/ChildSide/child_home_page.dart';

class ChildAddFriend extends StatefulWidget {
  const ChildAddFriend({super.key});

  @override
  _ChildAddFriendState createState() => _ChildAddFriendState();
}

class _ChildAddFriendState extends State<ChildAddFriend> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool _isLoading = false;
  bool _hasSearched = false;
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  List<UserProfile> _getFilteredResults() {
    if (_searchQuery.isEmpty || !_hasSearched) {
      return [];
    } else {
      // For children, we require at least 3 characters for safety
      if (_searchQuery.length < 3) {
        return [];
      }
      
      return mockChildProfiles
          .where((profile) => profile.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  void _sendFriendRequest(UserProfile profile) {
    setState(() {
      _isLoading = true;
    });
    
    // Create a new friend request
    final newRequest = FriendRequest(
      id: 'req_c_${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'current_child',
      senderName: 'Jade', 
      senderImage: 'assets/child_pf.png',
      receiverId: profile.id,
      receiverName: profile.name,
      receiverImage: profile.image,
      requestTime: DateTime.now(),
    );
    
    // Simulate server request with longer delay for child UI
    Future.delayed(Duration(seconds: 2), () {
      // Update the profile status
      for (int i = 0; i < mockChildProfiles.length; i++) {
        if (mockChildProfiles[i].id == profile.id) {
          mockChildProfiles[i].hasRequestPending = true;
          break;
        }
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('Friend request sent to ${profile.name}!'),
            ],
          ),
          backgroundColor: Colors.amber,
          duration: Duration(seconds: 3),
        ),
      );
      setState(() {
        _isLoading = false;
        // Refresh the list
        _searchQuery = _searchController.text;
        _hasSearched = true;
      });
      //Navigator.pop(context); - Let the user continue searching
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: Column(
          children: [
            // Header with gradient background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.yellow.shade300,
                    Color.fromARGB(255, 251, 239, 215),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 25),
              child: Column(
                children: [
                  // App bar
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
                            Icons.person_add,
                            color: Colors.amber[600],
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Find Friends',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Search bar
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Enter your friend\'s username',
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey[500],
                                fontSize: 15,
                              ),
                              prefixIcon: Icon(Icons.search, color: Colors.amber),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchQuery = _searchController.text;
                              _hasSearched = true;
                            });
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            height: 55,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Icon(Icons.search, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Results section
            Expanded(
              child: _isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.amber,
                            strokeWidth: 5,
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Sending friend request...',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : _buildSearchResults(),
            ),
            
            // Friend requests banner
            if (mockChildPendingRequests.isNotEmpty)
              GestureDetector(
                onTap: _showFriendRequests,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person_add,
                              color: Colors.amber,
                              size: 30,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${mockChildPendingRequests.length}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Friend Requests',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${mockChildPendingRequests.length} new requests to be friends!',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSearchResults() {
    final List<UserProfile> results = _getFilteredResults();
    
    // Show instructions before searching
    if (!_hasSearched) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/search_friends.png', // Replace with appropriate image
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.people,
                  size: 100,
                  color: Colors.amber.withOpacity(0.5),
                );
              },
            ),
            SizedBox(height: 24),
            Text(
              'Find Your Friends!',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Type your friend\'s name in the search box to find them',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    // Show message if search query is too short
    if (_searchQuery.length < 3) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search,
                size: 60,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Keep typing...',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Please type at least 3 letters to search for friends',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    // Show no results message
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off,
                size: 60,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'No friends found',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'We couldn\'t find anyone with that name. Try a different name!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    // Show search results
    return ListView.builder(
      itemCount: results.length,
      padding: EdgeInsets.all(20),
      itemBuilder: (context, index) {
        final profile = results[index];
        return _buildFriendCard(profile);
      },
    );
  }
  
  Widget _buildFriendCard(UserProfile profile) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.amber,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: profile.image != null ? AssetImage(profile.image!) : null,
                backgroundColor: profile.image == null ? Colors.amber.shade200 : null,
                child: profile.image == null
                    ? Text(
                        profile.name[0],
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  if (profile.bio != null)
                    Text(
                      profile.bio!,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 8),
            if (profile.isFriend)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Friends',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.green[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            else if (profile.hasRequestPending)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Sent',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.orange[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            else
              ElevatedButton(
                onPressed: () => _sendFriendRequest(profile),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Add Friend',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  void _showFriendRequests() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: Colors.amber,
                    size: 24,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Friend Requests',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                constraints: BoxConstraints(maxHeight: 300),
                child: mockChildPendingRequests.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check_circle_outline,
                                size: 40,
                                color: Colors.amber,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'All done!',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'You have no new friend requests',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: mockChildPendingRequests.length,
                        itemBuilder: (context, index) {
                          final request = mockChildPendingRequests[index];
                          return _buildRequestItem(request, index);
                        },
                      ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 40),
                ),
                child: Text(
                  'Close',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildRequestItem(FriendRequest request, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: request.senderImage != null
                    ? AssetImage(request.senderImage!)
                    : null,
                backgroundColor:
                    request.senderImage == null ? Colors.amber.shade300 : null,
                child: request.senderImage == null
                    ? Text(
                        request.senderName[0],
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.senderName,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Wants to be your friend',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Decline request
                    _handleRejectRequest(request, index);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade300,
                    side: BorderSide(color: Colors.red.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    'Decline',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Accept request
                    _handleAcceptRequest(request, index);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    'Accept',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  void _handleAcceptRequest(FriendRequest request, int index) {
    // Create a new chat conversation from the request
    final newChat = ChatConversation(
      id: 'chat_${request.id}',
      name: request.senderName,
      image: request.senderImage,
      lastMessage: 'You are now friends!',
      lastMessageTime: DateTime.now(),
      isUnread: true,
      messages: [
        ChatMessage(
          text: 'You are now friends with ${request.senderName}!',
          isUser: false,
          senderName: 'System',
          time: DateTime.now(),
        ),
      ],
    );
    
    // Add to child chats
    childMockChats.add(newChat);
    
    // Find the profile and update its status
    for (var child in mockChildProfiles) {
      if (child.id == request.senderId) {
        child.isFriend = true;
        child.hasRequestPending = false;
        break;
      }
    }
    
    setState(() {
      // Remove the request from pending
      mockChildPendingRequests.removeAt(index);
    });
    
    Navigator.pop(context);
    
    // Show a fun, child-friendly confirmation with animation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.amber,
        duration: Duration(seconds: 4),
        content: Row(
          children: [
            Icon(Icons.celebration, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hooray! New Friend!',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'You and ${request.senderName} are now friends',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'CHAT NOW',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Return to chat list
          },
        ),
      ),
    );
  }
  
  void _handleRejectRequest(FriendRequest request, int index) {
    setState(() {
      // Remove the request from pending
      mockChildPendingRequests.removeAt(index);
    });
    
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Friend request declined'),
        backgroundColor: Colors.grey[700],
      ),
    );
  }
} 