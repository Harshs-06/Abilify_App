import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:abilify/models/chat_model.dart';

class ParentChatDetail extends StatefulWidget {
  final ChatConversation conversation;
  
  const ParentChatDetail({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  _ParentChatDetailState createState() => _ParentChatDetailState();
}

class _ParentChatDetailState extends State<ParentChatDetail> {
  final TextEditingController _messageController = TextEditingController();
  late List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = List.from(widget.conversation.messages);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    _messageController.clear();
    
    if (text.trim().isEmpty) return;
    
    ChatMessage message = ChatMessage(
      text: text,
      isUser: true,
      senderName: 'Palak',
      senderImage: 'assets/profile_p2.png',
    );
    
    setState(() {
      _messages.add(message);
    });
    
    // Simulate response for demo purposes
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      
      final responses = [
        'That\'s a great point!',
        'I agree with you.',
        'Thanks for sharing that information.',
        'I\'ll keep that in mind.',
        'I appreciate your perspective on this.',
      ];
      
      final randomResponse = responses[DateTime.now().millisecond % responses.length];
      
      ChatMessage botMessage = ChatMessage(
        text: randomResponse,
        isUser: false,
        senderName: widget.conversation.name,
        senderImage: widget.conversation.image,
      );
      
      setState(() {
        _messages.add(botMessage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 240, 230, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.conversation.image != null 
                  ? AssetImage(widget.conversation.image!)
                  : null,
              backgroundColor: Color(0xFF9471E1),
              child: widget.conversation.image == null 
                  ? Text(
                      widget.conversation.name[0],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12),
            Text(
              widget.conversation.name,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final showAvatar = index == 0 || 
                    _messages[index - 1].isUser != message.isUser;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: message.isUser 
                        ? MainAxisAlignment.end 
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!message.isUser) ...[
                        if (showAvatar)
                          CircleAvatar(
                            backgroundImage: message.senderImage != null
                                ? AssetImage(message.senderImage!)
                                : null,
                            backgroundColor: Color(0xFF9471E1),
                            radius: 16,
                            child: message.senderImage == null
                                ? Text(
                                    message.senderName[0],
                                    style: TextStyle(color: Colors.white),
                                  )
                                : null,
                          )
                        else
                          SizedBox(width: 32),
                        SizedBox(width: 8),
                      ],
                      
                      Column(
                        crossAxisAlignment: message.isUser
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (showAvatar && !message.isUser)
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0, bottom: 2.0),
                              child: Text(
                                message.senderName,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: message.isUser
                                  ? Color(0xFF9471E1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              message.text,
                              style: GoogleFonts.poppins(
                                color: message.isUser
                                    ? Colors.white
                                    : Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
                            child: Text(
                              DateFormat('hh:mm a').format(message.time),
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      if (message.isUser) ...[
                        SizedBox(width: 8),
                        if (showAvatar)
                          CircleAvatar(
                            backgroundImage: message.senderImage != null
                                ? AssetImage(message.senderImage!)
                                : null,
                            backgroundColor: Color(0xFF9471E1),
                            radius: 16,
                            child: message.senderImage == null
                                ? Text(
                                    message.senderName[0],
                                    style: TextStyle(color: Colors.white),
                                  )
                                : null,
                          )
                        else
                          SizedBox(width: 32),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Input Box
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, color: Color(0xFF9471E1)),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF9471E1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () => _handleSubmitted(_messageController.text),
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