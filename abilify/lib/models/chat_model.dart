
class ChatMessage {
  final String text;
  final bool isUser;
  final String senderName;
  final String? senderImage;
  final DateTime time;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.senderName,
    this.senderImage,
    DateTime? time,
  }) : time = time ?? DateTime.now();
}

class ChatConversation {
  final String id;
  final String name;
  final String lastMessage;
  final String? image;
  final DateTime lastMessageTime;
  final bool isUnread;
  final List<ChatMessage> messages;
  
  ChatConversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    this.image,
    required this.lastMessageTime,
    required this.isUnread,
    required this.messages,
  });
}

// Mock data for parent chats
List<ChatConversation> parentMockChats = [
  ChatConversation(
    id: '1',
    name: 'Lisa Wong',
    image: 'assets/parent1.png',
    lastMessage: 'Are you attending the support group on Friday?',
    lastMessageTime: DateTime.now().subtract(Duration(minutes: 15)),
    isUnread: true,
    messages: [
      ChatMessage(
        text: 'Hi! I saw you also have a child with special needs.',
        isUser: false, 
        senderName: 'Lisa Wong',
        senderImage: 'assets/parent1.png',
        time: DateTime.now().subtract(Duration(days: 1, hours: 2)),
      ),
      ChatMessage(
        text: 'Yes, my son was diagnosed with autism last year.',
        isUser: true, 
        senderName: 'Palak',
        senderImage: 'assets/profile_p2.png',
        time: DateTime.now().subtract(Duration(days: 1, hours: 1, minutes: 45)),
      ),
      ChatMessage(
        text: 'I found a really good occupational therapist that helped us a lot.',
        isUser: false, 
        senderName: 'Lisa Wong', 
        senderImage: 'assets/parent1.png',
        time: DateTime.now().subtract(Duration(days: 1, hours: 1, minutes: 30)),
      ),
      ChatMessage(
        text: 'Would you mind sharing their details with me?',
        isUser: true, 
        senderName: 'Palak',
        senderImage: 'assets/profile_p2.png',
        time: DateTime.now().subtract(Duration(days: 1, hours: 1, minutes: 15)),
      ),
      ChatMessage(
        text: 'Of course! I\'ll send you the information later today.',
        isUser: false, 
        senderName: 'Lisa Wong',
        senderImage: 'assets/parent1.png',
        time: DateTime.now().subtract(Duration(days: 1)),
      ),
      ChatMessage(
        text: 'Are you attending the support group on Friday?',
        isUser: false, 
        senderName: 'Lisa Wong',
        senderImage: 'assets/parent1.png',
        time: DateTime.now().subtract(Duration(minutes: 15)),
      ),
    ],
  ),
  ChatConversation(
    id: '2',
    name: 'Mark Johnson',
    image: 'assets/parent2.png',
    lastMessage: 'The school program has really helped my daughter.',
    lastMessageTime: DateTime.now().subtract(Duration(hours: 2)),
    isUnread: false,
    messages: [
      ChatMessage(
        text: 'Hi Palak! I see you\'re also at Jefferson Elementary.',
        isUser: false, 
        senderName: 'Mark Johnson',
        senderImage: 'assets/parent2.png',
        time: DateTime.now().subtract(Duration(days: 2, hours: 5)),
      ),
      ChatMessage(
        text: 'Yes, my child just started in the special education program there.',
        isUser: true,
        senderName: 'Palak',
        senderImage: 'assets/profile_p2.png',
        time: DateTime.now().subtract(Duration(days: 2, hours: 4, minutes: 45)),
      ),
      ChatMessage(
        text: 'How are you finding it? My daughter has been there for a year now.',
        isUser: false,
        senderName: 'Mark Johnson',
        senderImage: 'assets/parent2.png',
        time: DateTime.now().subtract(Duration(days: 2, hours: 4, minutes: 30)),
      ),
      ChatMessage(
        text: 'It\'s been challenging to adjust, but the teachers seem great.',
        isUser: true,
        senderName: 'Palak',
        senderImage: 'assets/profile_p2.png',
        time: DateTime.now().subtract(Duration(days: 1, hours: 3)),
      ),
      ChatMessage(
        text: 'The school program has really helped my daughter.',
        isUser: false,
        senderName: 'Mark Johnson',
        senderImage: 'assets/parent2.png',
        time: DateTime.now().subtract(Duration(hours: 2)),
      ),
    ],
  ),
];

// Mock data for child chats
List<ChatConversation> childMockChats = [
  ChatConversation(
    id: '1',
    name: 'Alex',
    image: 'assets/child1.png',
    lastMessage: 'Do you want to join my Minecraft server?',
    lastMessageTime: DateTime.now().subtract(Duration(minutes: 30)),
    isUnread: true,
    messages: [
      ChatMessage(
        text: 'Hi! I\'m Alex. I saw you like space games too!',
        isUser: false,
        senderName: 'Alex',
        senderImage: 'assets/child1.png',
        time: DateTime.now().subtract(Duration(days: 1, hours: 3)),
      ),
      ChatMessage(
        text: 'Hi Alex! Yes, I love space games. What\'s your favorite?',
        isUser: true,
        senderName: 'Jade',
        senderImage: 'assets/child_pf.png',
        time: DateTime.now().subtract(Duration(days: 1, hours: 2, minutes: 55)),
      ),
      ChatMessage(
        text: 'I like Astroneer! Have you played it?',
        isUser: false,
        senderName: 'Alex',
        senderImage: 'assets/child1.png',
        time: DateTime.now().subtract(Duration(days: 1, hours: 2, minutes: 45)),
      ),
      ChatMessage(
        text: 'No, but it looks cool! I like Minecraft space mods.',
        isUser: true,
        senderName: 'Jade',
        senderImage: 'assets/child_pf.png',
        time: DateTime.now().subtract(Duration(days: 1, hours: 2, minutes: 30)),
      ),
      ChatMessage(
        text: 'Do you want to join my Minecraft server?',
        isUser: false,
        senderName: 'Alex',
        senderImage: 'assets/child1.png',
        time: DateTime.now().subtract(Duration(minutes: 30)),
      ),
    ],
  ),
  ChatConversation(
    id: '2',
    name: 'Taylor',
    image: 'assets/child2.png',
    lastMessage: 'My teacher said I did great on my art project!',
    lastMessageTime: DateTime.now().subtract(Duration(hours: 1)),
    isUnread: false,
    messages: [
      ChatMessage(
        text: 'Hi Jade! I\'m Taylor from art class.',
        isUser: false,
        senderName: 'Taylor',
        senderImage: 'assets/child2.png',
        time: DateTime.now().subtract(Duration(days: 2, hours: 4)),
      ),
      ChatMessage(
        text: 'Hey Taylor! I remember you, you made that cool painting!',
        isUser: true,
        senderName: 'Jade',
        senderImage: 'assets/child_pf.png',
        time: DateTime.now().subtract(Duration(days: 2, hours: 3, minutes: 50)),
      ),
      ChatMessage(
        text: 'Yes! I\'m working on a new one with dinosaurs.',
        isUser: false,
        senderName: 'Taylor',
        senderImage: 'assets/child2.png',
        time: DateTime.now().subtract(Duration(days: 2, hours: 3, minutes: 40)),
      ),
      ChatMessage(
        text: 'That sounds awesome! I love dinosaurs.',
        isUser: true,
        senderName: 'Jade',
        senderImage: 'assets/child_pf.png',
        time: DateTime.now().subtract(Duration(days: 1, hours: 5)),
      ),
      ChatMessage(
        text: 'My teacher said I did great on my art project!',
        isUser: false,
        senderName: 'Taylor',
        senderImage: 'assets/child2.png',
        time: DateTime.now().subtract(Duration(hours: 1)),
      ),
    ],
  ),
];

// Mock data for professional chats
List<ChatConversation> professionalMockChats = [
  ChatConversation(
    id: '1',
    name: 'Dr. Sarah Miller',
    image: 'assets/story_time.png',
    lastMessage: 'We can discuss your child\'s progress at our next appointment.',
    lastMessageTime: DateTime.now().subtract(Duration(hours: 3)),
    isUnread: true,
    messages: [
      ChatMessage(
        text: 'Hello, I\'m Dr. Sarah Miller, developmental pediatrician. I received your inquiry about your child\'s assessment.',
        isUser: false, 
        senderName: 'Dr. Sarah Miller',
        senderImage: 'assets/story_time.png',
        time: DateTime.now().subtract(Duration(days: 2, hours: 5)),
      ),
      ChatMessage(
        text: 'Thank you for getting back to me, Dr. Miller. We\'re concerned about some developmental delays.',
        isUser: true, 
        senderName: 'Palak',
        senderImage: 'assets/profile_p2.png',
        time: DateTime.now().subtract(Duration(days: 2, hours: 4, minutes: 45)),
      ),
      ChatMessage(
        text: 'I understand your concerns. I\'d like to schedule an initial assessment to properly evaluate the situation.',
        isUser: false, 
        senderName: 'Dr. Sarah Miller', 
        senderImage: 'assets/story_time.png',
        time: DateTime.now().subtract(Duration(days: 2, hours: 4, minutes: 30)),
      ),
      ChatMessage(
        text: 'That would be great. When would you be available for that?',
        isUser: true, 
        senderName: 'Palak',
        senderImage: 'assets/profile_p2.png',
        time: DateTime.now().subtract(Duration(days: 2, hours: 4, minutes: 15)),
      ),
      ChatMessage(
        text: 'I have availability next Tuesday at 2pm or Thursday at 10am. Would either of those work for you?',
        isUser: false, 
        senderName: 'Dr. Sarah Miller',
        senderImage: 'assets/story_time.png',
        time: DateTime.now().subtract(Duration(days: 1, hours: 5)),
      ),
      ChatMessage(
        text: 'We can discuss your child\'s progress at our next appointment.',
        isUser: false, 
        senderName: 'Dr. Sarah Miller',
        senderImage: 'assets/story_time.png',
        time: DateTime.now().subtract(Duration(hours: 3)),
      ),
    ],
  ),
  ChatConversation(
    id: '2',
    name: 'T. Reynolds',
    image: 'assets/fun_games.png',
    lastMessage: 'I\'ve prepared some new exercises for our next session.',
    lastMessageTime: DateTime.now().subtract(Duration(days: 1, hours: 6)),
    isUnread: false,
    messages: [
      ChatMessage(
        text: 'Hi, I\'m Thomas Reynolds, occupational therapist. I received your referral from Dr. Miller.',
        isUser: false, 
        senderName: 'T. Reynolds',
        senderImage: 'assets/fun_games.png',
        time: DateTime.now().subtract(Duration(days: 7, hours: 4)),
      ),
      ChatMessage(
        text: 'Yes, she recommended you highly for helping with sensory integration.',
        isUser: true,
        senderName: 'Palak',
        senderImage: 'assets/profile_p2.png',
        time: DateTime.now().subtract(Duration(days: 7, hours: 3, minutes: 45)),
      ),
      ChatMessage(
        text: 'I\'ve been working with similar cases for over 10 years. I\'d be happy to help your child develop better sensory processing skills.',
        isUser: false,
        senderName: 'T. Reynolds',
        senderImage: 'assets/fun_games.png',
        time: DateTime.now().subtract(Duration(days: 7, hours: 3, minutes: 30)),
      ),
      ChatMessage(
        text: 'That sounds great. What kind of approach do you usually take?',
        isUser: true,
        senderName: 'Palak',
        senderImage: 'assets/profile_p2.png',
        time: DateTime.now().subtract(Duration(days: 7, hours: 3)),
      ),
      ChatMessage(
        text: 'I\'ve prepared some new exercises for our next session.',
        isUser: false,
        senderName: 'T. Reynolds',
        senderImage: 'assets/fun_games.png',
        time: DateTime.now().subtract(Duration(days: 1, hours: 6)),
      ),
    ],
  ),
  ChatConversation(
    id: '3',
    name: 'Emma Chen',
    image: 'assets/chat.png',
    lastMessage: 'The behavior plan is showing positive results.',
    lastMessageTime: DateTime.now().subtract(Duration(days: 2)),
    isUnread: false,
    messages: [
      ChatMessage(
        text: 'Hello Palak, I\'m Emma Chen, Board Certified Behavior Analyst. I understand you\'d like help with developing a behavior plan.',
        isUser: false,
        senderName: 'Emma Chen',
        senderImage: 'assets/chat.png',
        time: DateTime.now().subtract(Duration(days: 14, hours: 8)),
      ),
      ChatMessage(
        text: 'Yes, we\'ve been struggling with consistent tantrums during transitions.',
        isUser: true,
        senderName: 'Palak',
        senderImage: 'assets/profile_p2.png',
        time: DateTime.now().subtract(Duration(days: 14, hours: 7, minutes: 50)),
      ),
      ChatMessage(
        text: 'I understand how challenging that can be. I\'d like to observe a few transitions to develop a personalized plan.',
        isUser: false,
        senderName: 'Emma Chen',
        senderImage: 'assets/chat.png',
        time: DateTime.now().subtract(Duration(days: 14, hours: 7, minutes: 40)),
      ),
      ChatMessage(
        text: 'The behavior plan is showing positive results.',
        isUser: false,
        senderName: 'Emma Chen',
        senderImage: 'assets/chat.png',
        time: DateTime.now().subtract(Duration(days: 2)),
      ),
    ],
  ),
]; 