import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// A service to handle local data storage operations as a replacement for Firebase
class LocalDatabaseService {
  static final LocalDatabaseService _instance = LocalDatabaseService._internal();
  final String _usersCollection = 'users';
  final String _postsCollection = 'posts';
  final String _chatsCollection = 'chats';
  final String _friendsCollection = 'friends';
  final String _rewardsCollection = 'rewards';
  
  // Factory constructor
  factory LocalDatabaseService() {
    return _instance;
  }
  
  LocalDatabaseService._internal();
  
  // Generic method to save collection data
  Future<void> saveCollection<T>(String collection, Map<String, T> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = jsonEncode(data);
      await prefs.setString(collection, jsonData);
    } catch (e) {
      print('Error saving $collection data: $e');
    }
  }
  
  // Generic method to get collection data
  Future<Map<String, dynamic>> getCollection(String collection) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = prefs.getString(collection);
      if (jsonData == null) {
        return {};
      }
      return jsonDecode(jsonData) as Map<String, dynamic>;
    } catch (e) {
      print('Error getting $collection data: $e');
      return {};
    }
  }
  
  // User-related methods
  Future<void> saveUser(String userId, Map<String, dynamic> userData) async {
    final users = await getCollection(_usersCollection);
    users[userId] = userData;
    await saveCollection(_usersCollection, users);
  }
  
  Future<Map<String, dynamic>?> getUser(String userId) async {
    final users = await getCollection(_usersCollection);
    return users[userId];
  }
  
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final users = await getCollection(_usersCollection);
    return users.values.cast<Map<String, dynamic>>().toList();
  }
  
  // Post-related methods
  Future<void> savePost(String postId, Map<String, dynamic> postData) async {
    final posts = await getCollection(_postsCollection);
    posts[postId] = postData;
    await saveCollection(_postsCollection, posts);
  }
  
  Future<void> savePosts(List<Map<String, dynamic>> posts) async {
    final postsMap = <String, dynamic>{};
    for (var i = 0; i < posts.length; i++) {
      postsMap[posts[i]['id'] ?? i.toString()] = posts[i];
    }
    await saveCollection(_postsCollection, postsMap);
  }
  
  Future<List<Map<String, dynamic>>> getAllPosts() async {
    final posts = await getCollection(_postsCollection);
    return posts.values.cast<Map<String, dynamic>>().toList();
  }
  
  // Chat-related methods
  Future<void> saveChat(String chatId, Map<String, dynamic> chatData) async {
    final chats = await getCollection(_chatsCollection);
    chats[chatId] = chatData;
    await saveCollection(_chatsCollection, chats);
  }
  
  Future<void> saveChats(List<Map<String, dynamic>> chats) async {
    final chatsMap = <String, dynamic>{};
    for (var i = 0; i < chats.length; i++) {
      chatsMap[chats[i]['id'] ?? i.toString()] = chats[i];
    }
    await saveCollection(_chatsCollection, chatsMap);
  }
  
  Future<List<Map<String, dynamic>>> getAllChats() async {
    final chats = await getCollection(_chatsCollection);
    return chats.values.cast<Map<String, dynamic>>().toList();
  }
  
  // Friend-related methods
  Future<void> saveFriendRequest(String requestId, Map<String, dynamic> requestData) async {
    final requests = await getCollection(_friendsCollection);
    requests[requestId] = requestData;
    await saveCollection(_friendsCollection, requests);
  }
  
  Future<List<Map<String, dynamic>>> getAllFriendRequests() async {
    final requests = await getCollection(_friendsCollection);
    return requests.values.cast<Map<String, dynamic>>().toList();
  }

  // Generic document methods
  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    final String id = DateTime.now().millisecondsSinceEpoch.toString();
    data['id'] = id;
    
    final items = await getCollection(collection);
    items[id] = data;
    await saveCollection(collection, items);
  }

  Future<void> updateDocument(String collection, String documentId, Map<String, dynamic> data) async {
    final items = await getCollection(collection);
    
    if (items.containsKey(documentId)) {
      data['id'] = documentId;
      items[documentId] = data;
      await saveCollection(collection, items);
    }
  }
  
  Future<void> deleteDocument(String collection, String documentId) async {
    final items = await getCollection(collection);
    
    if (items.containsKey(documentId)) {
      items.remove(documentId);
      await saveCollection(collection, items);
    }
  }
} 