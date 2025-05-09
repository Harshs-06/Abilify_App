import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:abilify/models/chat_model.dart';

class ChildChatDetail extends StatefulWidget {
  final ChatConversation conversation;
  
  const ChildChatDetail({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  _ChildChatDetailState createState() => _ChildChatDetailState();
}

class _ChildChatDetailState extends State<ChildChatDetail> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<ChatMessage> _messages;
  final Map<String, String> _emojis = {
    ':)': '😊',
    ':D': '😃',
    ':(': '😔',
    ':P': '😛',
    ':O': '😮',
    '<3': '❤️',
  };

  @override
  void initState() {
    super.initState();
    _messages = List.from(widget.conversation.messages);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    _messageController.clear();
    
    if (text.trim().isEmpty) return;
    
    // Replace text emojis with actual emoji characters
    for (final entry in _emojis.entries) {
      text = text.replaceAll(entry.key, entry.value);
    }
    
    final message = ChatMessage(
      text: text,
      isUser: true,
      senderName: 'Jade',
      senderImage: 'assets/child_pf.png',
    );
    
    setState(() {
      _messages.add(message);
    });
    
    // Simulate response
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      
      final responses = [
        'That\'s cool!',
        'Really? Tell me more!',
        'I like that too!',
        'Awesome!',
        'That sounds fun!',
        'What else do you like to do?',
      ];
      
      final random = DateTime.now().millisecond % responses.length;
      final responseText = responses[random];
      
      final botMessage = ChatMessage(
        text: responseText,
        isUser: false,
        senderName: widget.conversation.name,
        senderImage: widget.conversation.image,
      );
      
      setState(() {
        _messages.add(botMessage);
      });
      
      // Scroll to the bottom
      Future.delayed(Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: Column(
          children: [
            // Header with gradient
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
              padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
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
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.amber,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: widget.conversation.image != null
                          ? AssetImage(widget.conversation.image!)
                          : null,
                      backgroundColor: Colors.amber.shade200,
                      child: widget.conversation.image == null
                          ? Text(
                              widget.conversation.name[0],
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.conversation.name,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Online',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.videocam,
                        color: Colors.amber,
                        size: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Chat messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final showAvatar = index == 0 || 
                      _messages[index - 1].isUser != message.isUser;
                  final showTime = index == 0 || 
                      _getDateWithoutTime(message.time) != _getDateWithoutTime(_messages[index - 1].time);
                  
                  return Column(
                    children: [
                      if (showTime)
                        _buildDateSeparator(message.time),
                      _buildMessageBubble(message, showAvatar),
                    ],
                  );
                },
              ),
            ),
            
            // Input box
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {}, // Would handle emoji picker
                      icon: Icon(Icons.emoji_emotions, color: Colors.amber),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                        maxLines: 1,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => _handleSubmitted(_messageController.text),
                      icon: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool showAvatar) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isUser) ...[
            if (showAvatar)
              CircleAvatar(
                backgroundImage: message.senderImage != null
                    ? AssetImage(message.senderImage!)
                    : null,
                backgroundColor: Colors.amber.shade200,
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
          
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Colors.amber.shade300
                    : Colors.white,
                borderRadius: BorderRadius.circular(20).copyWith(
                  bottomLeft: message.isUser || !showAvatar
                      ? Radius.circular(20)
                      : Radius.circular(0),
                  bottomRight: !message.isUser || !showAvatar
                      ? Radius.circular(20)
                      : Radius.circular(0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: GoogleFonts.poppins(
                      color: message.isUser
                          ? Colors.white
                          : Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 3),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      DateFormat('h:mm a').format(message.time),
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: message.isUser
                            ? Colors.white.withOpacity(0.7)
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (message.isUser) ...[
            SizedBox(width: 8),
            if (showAvatar)
              CircleAvatar(
                backgroundImage: message.senderImage != null
                    ? AssetImage(message.senderImage!)
                    : null,
                backgroundColor: Colors.amber.shade300,
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
  }

  Widget _buildDateSeparator(DateTime date) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey.withOpacity(0.3),
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              _formatMessageDate(date),
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey.withOpacity(0.3),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  String _formatMessageDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM d, y').format(date);
    }
  }

  DateTime _getDateWithoutTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
} 