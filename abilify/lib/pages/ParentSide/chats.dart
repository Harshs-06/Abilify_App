import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/widgets/bottom_navigation.dart';
import 'package:abilify/models/chat_model.dart';
import 'package:abilify/pages/ParentSide/parent_chat_detail.dart';
import 'package:abilify/pages/ParentSide/parent_add_contact.dart';
import 'package:abilify/pages/ParentSide/parent_home_page.dart';
import 'package:abilify/pages/ParentSide/service_directory.dart';
import 'package:abilify/pages/ParentSide/community_forum.dart';
import 'package:intl/intl.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  int _currentIndex = 3; // Set to 3 for Chats tab
  bool _showParents = true; // Toggle between Parents and Professionals

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
        case 2:
          Navigator.pushReplacementNamed(context, '/community_forum');
          break;
        case 3:
          // Already on chats page
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 240, 230, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Chats',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ParentAddContact()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showParents = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _showParents ? Color(0xFF9471E1) : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Parents',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: _showParents ? FontWeight.w600 : FontWeight.w500,
                          color: _showParents ? Color(0xFF9471E1) : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showParents = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: !_showParents ? Color(0xFF9471E1) : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Professionals',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: !_showParents ? FontWeight.w600 : FontWeight.w500,
                          color: !_showParents ? Color(0xFF9471E1) : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: _showParents 
                ? _buildChatList(parentMockChats)
                : _buildChatList(professionalMockChats),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ParentAddContact()),
          );
        },
        backgroundColor: Color(0xFF9471E1),
        child: Icon(Icons.chat, color: Colors.white),
      ),
      bottomNavigationBar: AbilifyBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
  
  Widget _buildChatList(List<ChatConversation> chats) {
    if (chats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: Color(0xFF9471E1),
            ),
            SizedBox(height: 16),
            Text(
              'No chats yet',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                _showParents 
                    ? 'Connect with other parents and professionals'
                    : 'Connect with specialists and therapists',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParentAddContact()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9471E1),
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                _showParents ? 'Find Connections' : 'Find Professionals',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return _buildChatItem(context, chat);
        },
      );
    }
  }
  
  Widget _buildChatItem(BuildContext context, ChatConversation chat) {
    final formattedTime = _formatLastMessageTime(chat.lastMessageTime);
    
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParentChatDetail(conversation: chat),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 24,
              backgroundImage: chat.image != null
                  ? AssetImage(chat.image!)
                  : null,
              backgroundColor: chat.image == null ? Color(0xFF9471E1) : null,
              child: chat.image == null
                  ? Text(
                      chat.name[0],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 16),
            
            // Chat details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat.name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: chat.isUnread
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        formattedTime,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: chat.isUnread
                              ? Color(0xFF9471E1)
                              : Colors.grey[600],
                          fontWeight: chat.isUnread
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: chat.isUnread
                                ? Colors.black87
                                : Colors.grey[600],
                            fontWeight: chat.isUnread
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (chat.isUnread)
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Color(0xFF9471E1),
                            shape: BoxShape.circle,
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
    );
  }
  
  String _formatLastMessageTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inDays > 0) {
      return DateFormat('dd/MM').format(time);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
} 