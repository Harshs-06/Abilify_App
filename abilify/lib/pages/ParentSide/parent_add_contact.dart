import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/models/friend_request_model.dart';
import 'package:abilify/models/chat_model.dart';
import 'package:intl/intl.dart';

class ParentAddContact extends StatefulWidget {
  const ParentAddContact({super.key});

  @override
  _ParentAddContactState createState() => _ParentAddContactState();
}

class _ParentAddContactState extends State<ParentAddContact> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _searchQuery = "";
        _searchController.clear();
      });
    });
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  
  List<UserProfile> _getFilteredResults() {
    if (_searchQuery.isEmpty) {
      switch (_tabController.index) {
        case 0:
          return mockParentProfiles;
        case 1:
          return mockProfessionalProfiles;
        case 2:
          return []; // In parent view, we don't list children until searched
        default:
          return [];
      }
    } else {
      List<UserProfile> results = [];
      switch (_tabController.index) {
        case 0:
          results = mockParentProfiles
              .where((profile) => profile.name.toLowerCase().contains(_searchQuery.toLowerCase()))
              .toList();
          break;
        case 1:
          results = mockProfessionalProfiles
              .where((profile) => 
                profile.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                (profile.specialization?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false))
              .toList();
          break;
        case 2:
          // For safety, we only allow specific search for children accounts
          if (_searchQuery.length >= 3) {
            results = mockChildProfiles
                .where((profile) => profile.name.toLowerCase().contains(_searchQuery.toLowerCase()))
                .toList();
          }
          break;
      }
      return results;
    }
  }

  void _sendFriendRequest(UserProfile profile) {
    setState(() {
      _isLoading = true;
    });
    
    // Create a new friend request
    final newRequest = FriendRequest(
      id: 'req_${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'current_parent', // Current user ID
      senderName: 'Palak', // Current user name
      senderImage: 'assets/profile_p2.png',
      receiverId: profile.id,
      receiverName: profile.name,
      receiverImage: profile.image,
      requestTime: DateTime.now(),
    );
    
    // Simulate server request
    Future.delayed(Duration(seconds: 1), () {
      // Update the profile status
      if (profile.userType == 'parent') {
        for (int i = 0; i < mockParentProfiles.length; i++) {
          if (mockParentProfiles[i].id == profile.id) {
            mockParentProfiles[i].hasRequestPending = true;
            break;
          }
        }
      } else if (profile.userType == 'professional') {
        for (int i = 0; i < mockProfessionalProfiles.length; i++) {
          if (mockProfessionalProfiles[i].id == profile.id) {
            mockProfessionalProfiles[i].hasRequestPending = true;
            break;
          }
        }
      } else if (profile.userType == 'child') {
        for (int i = 0; i < mockChildProfiles.length; i++) {
          if (mockChildProfiles[i].id == profile.id) {
            mockChildProfiles[i].hasRequestPending = true;
            break;
          }
        }
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Friend request sent to ${profile.name}'),
          backgroundColor: Color(0xFF9471E1),
        ),
      );
      setState(() {
        _isLoading = false;
        // Refresh the search results
        _searchQuery = _searchController.text;
      });
      //Navigator.pop(context); - Let the user continue searching
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 240, 230, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add Contact',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(250, 240, 230, 1),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for contacts...',
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                labelColor: Color(0xFF9471E1),
                unselectedLabelColor: Colors.grey[600],
                indicatorColor: Color(0xFF9471E1),
                tabs: [
                  Tab(text: 'Parents'),
                  Tab(text: 'Professionals'),
                  Tab(text: 'Children'),
                ],
                labelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF9471E1),
                    ),
                  )
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildContactList(),
                      _buildContactList(),
                      _buildContactList(),
                    ],
                  ),
          ),
          if (mockPendingRequests.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  _showPendingRequestsSheet();
                },
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF9471E1).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_add,
                        color: Color(0xFF9471E1),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pending Requests',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${mockPendingRequests.length} people have sent you friend requests',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF9471E1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${mockPendingRequests.length}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildContactList() {
    final List<UserProfile> results = _getFilteredResults();
    
    if (_tabController.index == 2 && _searchQuery.isEmpty) {
      // For children, require search
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'Search for a child\'s username',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'For safety reasons, please enter at least 3 characters to search for a child\'s account',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_search,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'No results found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Try different keywords or check your spelling',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      itemCount: results.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final profile = results[index];
        return _buildContactCard(profile);
      },
    );
  }
  
  Widget _buildContactCard(UserProfile profile) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: profile.image != null ? AssetImage(profile.image!) : null,
              backgroundColor: profile.image == null ? Color(0xFF9471E1) : null,
              child: profile.image == null
                  ? Text(
                      profile.name[0],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        profile.name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (profile.specialization != null) ...[
                        SizedBox(width: 4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(0xFF9471E1).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            profile.specialization!,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Color(0xFF9471E1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4),
                  if (profile.bio != null)
                    Text(
                      profile.bio!,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 8),
            if (profile.isFriend)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Connected',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            else if (profile.hasRequestPending)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Pending',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.orange[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            else
              ElevatedButton(
                onPressed: () => _sendFriendRequest(profile),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9471E1),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Connect',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  void _showPendingRequestsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Friend Requests',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: mockPendingRequests.isEmpty 
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No pending requests',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'You\'ve handled all incoming requests',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                  controller: scrollController,
                  itemCount: mockPendingRequests.length,
                  itemBuilder: (context, index) {
                    final request = mockPendingRequests[index];
                    return _buildRequestCard(request, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildRequestCard(FriendRequest request, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: request.senderImage != null
                      ? AssetImage(request.senderImage!)
                      : null,
                  backgroundColor: request.senderImage == null
                      ? Color(0xFF9471E1)
                      : null,
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
                        _formatRequestTime(request.requestTime),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Would like to connect with you',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Reject request
                    _handleRejectRequest(request, index);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[400]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: Text(
                    'Decline',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    // Accept request
                    _handleAcceptRequest(request, index);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9471E1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: Text(
                    'Accept',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _handleAcceptRequest(FriendRequest request, int index) {
    // Create a new chat conversation from the request
    final newChat = ChatConversation(
      id: 'chat_${request.id}',
      name: request.senderName,
      image: request.senderImage,
      lastMessage: 'You are now connected!',
      lastMessageTime: DateTime.now(),
      isUnread: true,
      messages: [
        ChatMessage(
          text: 'You are now connected with ${request.senderName}!',
          isUser: false,
          senderName: 'System',
          time: DateTime.now(),
        ),
      ],
    );
    
    // Add to parent chats if it's a parent or professional
    // Find the appropriate user profile
    UserProfile? profile;
    for (var p in mockParentProfiles) {
      if (p.id == request.senderId) {
        profile = p;
        break;
      }
    }
    if (profile == null) {
      for (var p in mockProfessionalProfiles) {
        if (p.id == request.senderId) {
          profile = p;
          professionalMockChats.add(newChat);
          break;
        }
      }
    } else {
      parentMockChats.add(newChat);
    }
    
    setState(() {
      // Remove the request from pending
      mockPendingRequests.removeAt(index);
    });
    
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request accepted! You are now connected with ${request.senderName}.'),
        backgroundColor: Color(0xFF9471E1),
        action: SnackBarAction(
          label: 'VIEW CHAT',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Return to the chats screen
          },
        ),
      ),
    );
  }
  
  void _handleRejectRequest(FriendRequest request, int index) {
    setState(() {
      // Remove the request from pending
      mockPendingRequests.removeAt(index);
    });
    
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request rejected'),
        backgroundColor: Colors.grey[700],
      ),
    );
  }
  
  String _formatRequestTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
} 