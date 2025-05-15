import 'package:flutter/foundation.dart';
import 'local_database_service.dart';
import 'local_auth_service.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

/// Service to handle data operations with the local database
class LocalDataService with ChangeNotifier {
  final LocalDatabaseService _db = LocalDatabaseService();
  final LocalAuthService _authService = LocalAuthService();
  final Uuid _uuid = Uuid();
  
  // Friend requests
  List<Map<String, dynamic>> _friendRequests = [];
  List<Map<String, dynamic>> get friendRequests => _friendRequests;
  
  // User posts
  List<Map<String, dynamic>> _posts = [];
  List<Map<String, dynamic>> get posts => _posts;
  
  // Chats
  List<Map<String, dynamic>> _chats = [];
  List<Map<String, dynamic>> get chats => _chats;
  
  // Community forum posts
  List<Map<String, dynamic>> _communityPosts = [];
  List<Map<String, dynamic>> get communityPosts => _communityPosts;
  
  // Creative corner posts
  List<Map<String, dynamic>> _creativeCornerPosts = [];
  List<Map<String, dynamic>> get creativeCornerPosts => _creativeCornerPosts;

  // Initialize data
  Future<void> init() async {
    await _loadFriendRequests();
    await _loadPosts();
    await _loadChats();
    await _loadCommunityPosts();
    await _loadCreativeCornerPosts();
  }
  
  // Friend request methods
  Future<void> _loadFriendRequests() async {
    try {
      _friendRequests = await _db.getAllFriendRequests();
      notifyListeners();
    } catch (e) {
      print('Error loading friend requests: $e');
    }
  }
  
  Future<void> sendFriendRequest({
    required String receiverId,
    required String receiverName,
    String? receiverImage,
  }) async {
    try {
      if (_authService.currentUser == null) {
        throw 'User not logged in';
      }
      
      final user = _authService.currentUser!;
      final requestId = '${user.uid}_${receiverId}_${DateTime.now().millisecondsSinceEpoch}';
      
      final requestData = {
        'id': requestId,
        'senderId': user.uid,
        'senderName': user.displayName ?? user.email,
        'senderImage': user.photoURL,
        'receiverId': receiverId,
        'receiverName': receiverName,
        'receiverImage': receiverImage,
        'requestTime': DateTime.now().toIso8601String(),
        'status': 'pending',
      };
      
      await _db.saveFriendRequest(requestId, requestData);
      await _loadFriendRequests();
    } catch (e) {
      throw e.toString();
    }
  }
  
  Future<void> updateFriendRequestStatus(String requestId, String status) async {
    try {
      final requests = await _db.getCollection('friends');
      if (requests.containsKey(requestId)) {
        final request = requests[requestId] as Map<String, dynamic>;
        request['status'] = status;
        await _db.saveFriendRequest(requestId, request);
        await _loadFriendRequests();
      }
    } catch (e) {
      throw e.toString();
    }
  }
  
  // Post methods
  Future<void> _loadPosts() async {
    try {
      _posts = await _db.getAllPosts();
      notifyListeners();
    } catch (e) {
      print('Error loading posts: $e');
    }
  }
  
  Future<void> addPost(Map<String, dynamic> postData) async {
    try {
      if (_authService.currentUser == null) {
        throw 'User not logged in';
      }
      
      final user = _authService.currentUser!;
      final postId = '${user.uid}_${DateTime.now().millisecondsSinceEpoch}';
      
      final post = {
        'id': postId,
        'authorId': user.uid,
        'authorName': user.displayName ?? user.email,
        'authorImage': user.photoURL,
        'timestamp': DateTime.now().toIso8601String(),
        ...postData,
      };
      
      await _db.savePost(postId, post);
      await _loadPosts();
    } catch (e) {
      throw e.toString();
    }
  }
  
  Future<void> updatePost(String postId, Map<String, dynamic> updates) async {
    try {
      final posts = await _db.getCollection('posts');
      if (posts.containsKey(postId)) {
        final post = posts[postId] as Map<String, dynamic>;
        post.addAll(updates);
        await _db.savePost(postId, post);
        await _loadPosts();
      }
    } catch (e) {
      throw e.toString();
    }
  }
  
  Future<void> deletePost(String postId) async {
    try {
      await _db.deleteDocument('posts', postId);
      await _loadPosts();
    } catch (e) {
      throw e.toString();
    }
  }
  
  // Chat methods
  Future<void> _loadChats() async {
    try {
      _chats = await _db.getAllChats();
      notifyListeners();
    } catch (e) {
      print('Error loading chats: $e');
    }
  }
  
  Future<void> sendMessage({
    required String chatId,
    required String message,
  }) async {
    try {
      if (_authService.currentUser == null) {
        throw 'User not logged in';
      }
      
      final user = _authService.currentUser!;
      
      // Get existing chat or create new one
      final chats = await _db.getCollection('chats');
      Map<String, dynamic> chat;
      
      if (chats.containsKey(chatId)) {
        chat = chats[chatId] as Map<String, dynamic>;
      } else {
        chat = {
          'id': chatId,
          'participants': [user.uid],
          'messages': [],
          'lastMessageTime': DateTime.now().toIso8601String(),
        };
      }
      
      // Add message
      final messages = chat['messages'] as List<dynamic>? ?? [];
      
      messages.add({
        'senderId': user.uid,
        'senderName': user.displayName ?? user.email,
        'senderImage': user.photoURL,
        'text': message,
        'timestamp': DateTime.now().toIso8601String(),
      });
      
      chat['messages'] = messages;
      chat['lastMessageTime'] = DateTime.now().toIso8601String();
      chat['lastMessage'] = message;
      
      await _db.saveChat(chatId, chat);
      await _loadChats();
    } catch (e) {
      throw e.toString();
    }
  }
  
  // Image storage methods
  Future<String> saveImageToLocalStorage(File imageFile) async {
    try {
      // Get application documents directory
      final appDocDir = await getApplicationDocumentsDirectory();
      
      // Generate a unique filename
      final filename = '${_uuid.v4()}${path.extension(imageFile.path)}';
      
      // Create the image path
      final localPath = path.join(appDocDir.path, 'images', filename);
      
      // Ensure the directory exists
      final imageDir = Directory(path.join(appDocDir.path, 'images'));
      if (!await imageDir.exists()) {
        await imageDir.create(recursive: true);
      }
      
      // Save the image file to local storage
      final savedFile = await imageFile.copy(localPath);
      return savedFile.path;
    } catch (e) {
      print('Error saving image: $e');
      throw 'Failed to save image: $e';
    }
  }
  
  Future<File?> getImageFromLocalStorage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        return file;
      }
      return null;
    } catch (e) {
      print('Error retrieving image: $e');
      return null;
    }
  }
  
  // Community Forum posts
  Future<void> _loadCommunityPosts() async {
    try {
      final postsCollection = await _db.getCollection('community_posts');
      _communityPosts = postsCollection.values.cast<Map<String, dynamic>>().toList();
      _communityPosts.sort((a, b) {
        final DateTime dateA = DateTime.parse(a['timestamp'] ?? DateTime.now().toIso8601String());
        final DateTime dateB = DateTime.parse(b['timestamp'] ?? DateTime.now().toIso8601String());
        return dateB.compareTo(dateA); // Sort by newest first
      });
      notifyListeners();
    } catch (e) {
      print('Error loading community posts: $e');
    }
  }
  
  Future<String> addCommunityPost(String content, File? imageFile) async {
    try {
      if (_authService.currentUser == null) {
        throw 'User not logged in';
      }
      
      final user = _authService.currentUser!;
      final postId = '${user.uid}_community_${DateTime.now().millisecondsSinceEpoch}';
      
      String? imagePath;
      bool isAsset = false;
      
      // Save image if provided
      if (imageFile != null) {
        imagePath = await saveImageToLocalStorage(imageFile);
        isAsset = false;
      }
      
      final post = {
        'id': postId,
        'userName': user.displayName ?? 'Me',
        'userHandle': '@${user.email.split('@')[0]}',
        'timePosted': 'Just now',
        'content': content,
        'imagePath': imagePath,
        'isAsset': isAsset,
        'likes': 0,
        'likedByMe': false,
        'timestamp': DateTime.now().toIso8601String(),
        'comments': [],
      };
      
      // Save post to database
      final communityPosts = await _db.getCollection('community_posts');
      communityPosts[postId] = post;
      await _db.saveCollection('community_posts', communityPosts);
      
      // Reload posts
      await _loadCommunityPosts();
      return postId;
    } catch (e) {
      print('Error adding community post: $e');
      throw e.toString();
    }
  }
  
  Future<void> toggleCommunityPostLike(String postId) async {
    try {
      final communityPosts = await _db.getCollection('community_posts');
      if (communityPosts.containsKey(postId)) {
        final post = communityPosts[postId] as Map<String, dynamic>;
        
        if (post['likedByMe'] == true) {
          post['likes'] = (post['likes'] as int) - 1;
        } else {
          post['likes'] = (post['likes'] as int) + 1;
        }
        post['likedByMe'] = !(post['likedByMe'] as bool);
        
        communityPosts[postId] = post;
        await _db.saveCollection('community_posts', communityPosts);
        await _loadCommunityPosts();
      }
    } catch (e) {
      print('Error toggling community post like: $e');
      throw e.toString();
    }
  }
  
  Future<void> addCommentToCommunityPost(String postId, String comment) async {
    try {
      final communityPosts = await _db.getCollection('community_posts');
      if (communityPosts.containsKey(postId)) {
        final post = communityPosts[postId] as Map<String, dynamic>;
        final comments = post['comments'] as List<dynamic>;
        
        comments.add({
          'text': comment,
          'author': _authService.currentUser?.displayName ?? 'Me',
          'timestamp': DateTime.now().toIso8601String(),
        });
        
        post['comments'] = comments;
        communityPosts[postId] = post;
        await _db.saveCollection('community_posts', communityPosts);
        await _loadCommunityPosts();
      }
    } catch (e) {
      print('Error adding comment to community post: $e');
      throw e.toString();
    }
  }
  
  // Creative Corner posts
  Future<void> _loadCreativeCornerPosts() async {
    try {
      final postsCollection = await _db.getCollection('creative_corner_posts');
      _creativeCornerPosts = postsCollection.values.cast<Map<String, dynamic>>().toList();
      _creativeCornerPosts.sort((a, b) {
        final DateTime dateA = DateTime.parse(a['timestamp'] ?? DateTime.now().toIso8601String());
        final DateTime dateB = DateTime.parse(b['timestamp'] ?? DateTime.now().toIso8601String());
        return dateB.compareTo(dateA); // Sort by newest first
      });
      notifyListeners();
    } catch (e) {
      print('Error loading creative corner posts: $e');
    }
  }
  
  Future<String> addCreativeCornerPost(String content, File imageFile) async {
    try {
      if (_authService.currentUser == null) {
        throw 'User not logged in';
      }
      
      final user = _authService.currentUser!;
      final postId = '${user.uid}_creative_${DateTime.now().millisecondsSinceEpoch}';
      
      // Save image (required for creative corner)
      final imagePath = await saveImageToLocalStorage(imageFile);
      
      final post = {
        'id': postId,
        'childName': user.displayName ?? 'Me',
        'timePosted': 'Just now',
        'content': content,
        'imagePath': imagePath,
        'isAsset': false,
        'likes': 0,
        'likedByMe': false,
        'comments': 0,
        'timestamp': DateTime.now().toIso8601String(),
      };
      
      // Save post to database
      final creativePosts = await _db.getCollection('creative_corner_posts');
      creativePosts[postId] = post;
      await _db.saveCollection('creative_corner_posts', creativePosts);
      
      // Reload posts
      await _loadCreativeCornerPosts();
      return postId;
    } catch (e) {
      print('Error adding creative corner post: $e');
      throw e.toString();
    }
  }
  
  Future<void> toggleCreativeCornerPostLike(String postId) async {
    try {
      final creativePosts = await _db.getCollection('creative_corner_posts');
      if (creativePosts.containsKey(postId)) {
        final post = creativePosts[postId] as Map<String, dynamic>;
        
        if (post['likedByMe'] == true) {
          post['likes'] = (post['likes'] as int) - 1;
        } else {
          post['likes'] = (post['likes'] as int) + 1;
        }
        post['likedByMe'] = !(post['likedByMe'] as bool);
        
        creativePosts[postId] = post;
        await _db.saveCollection('creative_corner_posts', creativePosts);
        await _loadCreativeCornerPosts();
      }
    } catch (e) {
      print('Error toggling creative corner post like: $e');
      throw e.toString();
    }
  }
  
  // Initialize app with mock data if needed
  Future<void> initializeWithMockData({bool force = false}) async {
    final postsCollection = await _db.getCollection('posts');
    
    // Only initialize if data is empty or forced
    if (postsCollection.isEmpty || force) {
      // Load posts from community_forum.dart
      final mockPosts = [
        {
          'id': 'mock1',
          'authorId': 'mock_user1',
          'authorName': 'Thomas Magnum',
          'authorHandle': '@allOnBoard',
          'authorImage': 'assets/story_time.png',
          'content': 'You deserve a love with no trauma attached to it. A love '
              'that is goof for your mental health, a love that is kind to '
              'you. I\'am talking about people NOT suffering from mental '
              'health issues.',
          'timestamp': DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
          'likes': 55600,
          'likedByMe': false,
          'comments': [
            {'text': 'This is so meaningful, thank you!', 'author': 'Jane D.'},
            {'text': 'Needed to hear this today ❤️', 'author': 'Michael S.'},
          ],
        },
        {
          'id': 'mock2',
          'authorId': 'mock_user2',
          'authorName': 'Sarah Johnson',
          'authorHandle': '@sarahJ',
          'authorImage': null,
          'content': 'Just had a breakthrough with my son today during therapy. '
              'The techniques we\'ve been using are finally showing results! '
              'So grateful for this community and all the support.',
          'timestamp': DateTime.now().subtract(Duration(days: 2)).toIso8601String(),
          'likes': 124,
          'likedByMe': false,
          'comments': [
            {'text': 'That\'s amazing news!', 'author': 'Mark H.'},
            {'text': 'So happy for you both!', 'author': 'Lisa P.'},
          ],
        },
      ];
      
      // Save mock posts
      final postsMap = <String, dynamic>{};
      for (var post in mockPosts) {
        // Ensure post['id'] is properly converted to string
        String postId = post['id'].toString();
        postsMap[postId] = post;
      }
      await _db.saveCollection('posts', postsMap);
      
      // Create a test user if none exists
      final users = await _db.getCollection('users');
      if (users.isEmpty) {
        final testUser = {
          'uid': 'test_user',
          'email': 'test@example.com',
          'password': 'password123',
          'displayName': 'Test User',
          'photoURL': null,
        };
        await _db.saveUser('test_user', testUser);
      }
      
      // Initialize community posts
      final communityPostsMap = <String, dynamic>{};
      communityPostsMap['mock1'] = {
        'id': 'mock1',
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
        'timestamp': DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
        'comments': [
          {'text': 'This is so meaningful, thank you!', 'author': 'Jane D.'},
          {'text': 'Needed to hear this today ❤️', 'author': 'Michael S.'},
        ],
      };
      
      // Initialize creative corner posts
      final creativePostsMap = <String, dynamic>{};
      creativePostsMap['mock1'] = {
        'id': 'mock1',
        'childName': 'Jade',
        'timePosted': 'Today, 2:30 PM',
        'content': 'I drew this picture of my family at the park!',
        'imagePath': 'assets/story_time.png',
        'isAsset': true,
        'likes': 15,
        'likedByMe': false,
        'comments': 4,
        'timestamp': DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
      };
      
      await _db.saveCollection('community_posts', communityPostsMap);
      await _db.saveCollection('creative_corner_posts', creativePostsMap);
      
      // Load data again
      await init();
    }
  }
} 