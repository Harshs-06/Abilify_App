import 'package:abilify/models/resource.dart';

// Mock data for resources
final List<Map<String, dynamic>> mockResources = [
  {
    'id': 'article_1',
    'title': 'Understanding Sensory Processing',
    'category': 'sensory',
    'type': 'article',
    'content': 'Sensory processing is how the brain receives and interprets sensory information. For some children, this process may not function smoothly, leading to sensory processing difficulties. Signs may include heightened sensitivity to sound, touch, or movement, or seeking intense sensory experiences.',
    'image_url': 'https://example.com/images/sensory.jpg',
  },
  {
    'id': 'article_2',
    'title': 'Speech Therapy Basics',
    'category': 'speech',
    'type': 'article',
    'content': 'Speech therapy helps children improve their communication skills. This includes articulation (how we make sounds), fluency (rhythm of speech), and language comprehension. Regular practice at home with guided activities can significantly improve outcomes.',
    'image_url': 'https://example.com/images/speech.jpg',
  },
  {
    'id': 'video_1',
    'title': 'Calming Techniques for Overstimulation',
    'category': 'behavioral',
    'type': 'video',
    'content': 'This video demonstrates effective calming techniques for children experiencing sensory overstimulation.',
    'url': 'https://example.com/videos/calming-techniques.mp4',
    'image_url': 'https://example.com/images/calming.jpg',
  },
  {
    'id': 'guide_1',
    'title': 'Fine Motor Skills Development',
    'category': 'occupational',
    'type': 'guide',
    'content': 'A comprehensive guide to developing fine motor skills through age-appropriate activities and exercises. Includes printable worksheets and tracking tools.',
    'image_url': 'https://example.com/images/motor-skills.jpg',
  },
  {
    'id': 'article_3',
    'title': 'Supporting Learning at Home',
    'category': 'educational',
    'type': 'article',
    'content': 'Creating a supportive learning environment at home is crucial for children with special needs. This article explores how to structure routines, set up learning spaces, and incorporate learning into daily activities.',
    'image_url': 'https://example.com/images/home-learning.jpg',
  },
  {
    'id': 'video_2',
    'title': 'Introduction to AAC Devices',
    'category': 'speech',
    'type': 'video',
    'content': 'An introduction to Augmentative and Alternative Communication (AAC) devices and how they can help non-verbal or minimally verbal children communicate effectively.',
    'url': 'https://example.com/videos/aac-intro.mp4',
    'image_url': 'https://example.com/images/aac.jpg',
  },
  {
    'id': 'guide_2',
    'title': 'Parent Self-Care Guide',
    'category': 'parenting',
    'type': 'guide',
    'content': 'Self-care is essential for parents of children with special needs. This guide offers practical tips for managing stress, finding support, and maintaining well-being while caring for your child.',
    'image_url': 'https://example.com/images/self-care.jpg',
  },
  {
    'id': 'article_4',
    'title': 'Understanding IEPs and 504 Plans',
    'category': 'educational',
    'type': 'article',
    'content': 'A comprehensive explanation of Individualized Education Programs (IEPs) and 504 Plans, their differences, and how to advocate for your child\'s educational needs.',
    'image_url': 'https://example.com/images/education-plans.jpg',
  },
];

// Mock data for forum posts
final List<Map<String, dynamic>> mockForumPosts = [
  {
    'id': 'post_1',
    'title': 'Tips for sensory play',
    'author': 'SensoryMom',
    'content': 'What are your favorite sensory play activities? My 5-year-old loves playing with kinetic sand and water beads. Would love to hear your ideas!',
    'date': '2025-04-01',
    'replies': [
      {
        'author': 'PlayfulDad',
        'content': 'We make "sensory bottles" with water, glitter, and small toys. My daughter loves to watch them and it helps her calm down.',
        'date': '2025-04-02',
      },
      {
        'author': 'OTSpecialist',
        'content': 'Try sensory bins with different textures like rice, beans, or pasta. You can hide small toys in them for a fun seek-and-find activity.',
        'date': '2025-04-03',
      },
    ],
  },
  {
    'id': 'post_2',
    'title': 'Speech therapy resources',
    'author': 'TalkingMom',
    'content': 'We\'ve just started speech therapy for my son. Does anyone have recommendations for apps or games that reinforce speech practice at home?',
    'date': '2025-04-05',
    'replies': [
      {
        'author': 'SpeechPath123',
        'content': 'Check out the "Articulation Station" app. It\'s been great for practicing specific sounds with my clients.',
        'date': '2025-04-06',
      },
    ],
  },
  {
    'id': 'post_3',
    'title': 'Managing meltdowns in public',
    'author': 'AutismDad',
    'content': 'My 6-year-old son had a massive meltdown at the grocery store yesterday. It was heartbreaking and overwhelming. How do you all handle meltdowns in public places?',
    'date': '2025-04-08',
    'replies': [
      {
        'author': 'CalmMama',
        'content': 'Noise-cancelling headphones have been a game-changer for us. Also, having a visual schedule of what to expect during the shopping trip helps prevent surprises.',
        'date': '2025-04-09',
      },
      {
        'author': 'BehaviorSpecialist',
        'content': 'Consider creating a "meltdown kit" with sensory items that help your child calm down. And remember, your child isn\'t giving you a hard time - they\'re having a hard time.',
        'date': '2025-04-10',
      },
    ],
  },
  {
    'id': 'post_4',
    'title': 'School accommodations success story',
    'author': 'AdvocateMom',
    'content': 'After months of working with the school, we finally got the accommodations my daughter needs! Her anxiety has decreased dramatically and she\'s actually enjoying school now.',
    'date': '2025-04-12',
    'replies': [
      {
        'author': 'EducationRights',
        'content': 'That\'s wonderful! Would you mind sharing what specific accommodations have been most helpful? It might help others who are advocating for their children.',
        'date': '2025-04-13',
      },
    ],
  },
];

// Mock data for buddy program volunteers
final List<Map<String, dynamic>> mockBuddies = [
  {
    'id': 'buddy_1',
    'name': 'Sarah Johnson',
    'occupation': 'Special Education Teacher',
    'skills': ['Autism Support', 'IEP Guidance', 'Behavior Management'],
    'bio': 'I\'ve been working with special needs children for over 10 years. I specialize in autism support and can help navigate the education system.',
    'availability': 'Evenings and weekends',
    'image_url': 'https://example.com/images/sarah.jpg',
  },
  {
    'id': 'buddy_2',
    'name': 'Miguel Santos',
    'occupation': 'Occupational Therapist',
    'skills': ['Sensory Processing', 'Fine Motor Skills', 'Adaptive Equipment'],
    'bio': 'As an OT, I love helping children develop the skills they need for daily activities. I can share practical exercises and adaptations for home.',
    'availability': 'Tuesday and Thursday evenings',
    'image_url': 'https://example.com/images/miguel.jpg',
  },
  {
    'id': 'buddy_3',
    'name': 'Lisa Chen',
    'occupation': 'Speech Language Pathologist',
    'skills': ['Speech Therapy', 'AAC Devices', 'Language Development'],
    'bio': 'I specialize in helping non-verbal and minimally verbal children find their voice. I can provide guidance on communication strategies and tools.',
    'availability': 'Monday and Wednesday afternoons',
    'image_url': 'https://example.com/images/lisa.jpg',
  },
  {
    'id': 'buddy_4',
    'name': 'James Wilson',
    'occupation': 'Parent Mentor',
    'skills': ['Parent Support', 'Resource Navigation', 'Self-Care'],
    'bio': 'As a dad of two children with special needs, I\'ve been through the journey and understand the challenges. I\'m here to listen and share experiences.',
    'availability': 'Flexible schedule',
    'image_url': 'https://example.com/images/james.jpg',
  },
];

// Mock data for child activities
final List<Map<String, dynamic>> mockActivities = [
  {
    'id': 'coloring',
    'title': 'Coloring Game',
    'description': 'Express your creativity with our digital coloring book!',
    'points': 10,
    'icon': 'palette',
    'color': 0xFFFF5252,
  },
  {
    'id': 'memory',
    'title': 'Memory Game',
    'description': 'Match the pairs and train your memory!',
    'points': 15,
    'icon': 'psychology',
    'color': 0xFF448AFF,
  },
  {
    'id': 'music',
    'title': 'Music Player',
    'description': 'Listen to calming music and sounds',
    'points': 5,
    'icon': 'music_note',
    'color': 0xFF66BB6A,
  },
  {
    'id': 'story',
    'title': 'Story Time',
    'description': 'Read along with fun, interactive stories',
    'points': 20,
    'icon': 'book',
    'color': 0xFFFFD740,
  },
];

// Mock data for badges
final List<Map<String, dynamic>> mockBadges = [
  {
    'id': 'star_player',
    'title': 'Star Player',
    'description': 'Earned 50 points by completing activities',
    'image': 'assets/images/badge_star.png',
    'requiredPoints': 50,
  },
  {
    'id': 'super_helper',
    'title': 'Super Helper',
    'description': 'Earned 100 points by helping others',
    'image': 'assets/images/badge_helper.png',
    'requiredPoints': 100,
  },
  {
    'id': 'reading_champion',
    'title': 'Reading Champion',
    'description': 'Completed 5 stories in Story Time',
    'image': 'assets/images/badge_book.png',
    'requiredPoints': 0,
    'specialRequirement': 'Read 5 stories',
  },
  {
    'id': 'music_maestro',
    'title': 'Music Maestro',
    'description': 'Listened to all music tracks',
    'image': 'assets/images/badge_music.png',
    'requiredPoints': 0,
    'specialRequirement': 'Listen to all music tracks',
  },
];

// Get resources from mock data
List<Resource> getResources() {
  return mockResources.map((resource) => Resource.fromMap(resource)).toList();
}

// Get resources by category
List<Resource> getResourcesByCategory(String category) {
  return mockResources
      .where((resource) => resource['category'] == category)
      .map((resource) => Resource.fromMap(resource))
      .toList();
}

// Get resource by ID
Resource? getResourceById(String id) {
  final resourceMap = mockResources.firstWhere(
    (resource) => resource['id'] == id,
    orElse: () => <String, dynamic>{},
  );
  
  if (resourceMap.isEmpty) return null;
  return Resource.fromMap(resourceMap);
} 