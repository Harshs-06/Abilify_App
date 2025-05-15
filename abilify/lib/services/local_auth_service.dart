import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'local_database_service.dart';

class LocalUser {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoURL;

  LocalUser({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }

  factory LocalUser.fromMap(Map<String, dynamic> map) {
    return LocalUser(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      photoURL: map['photoURL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalUser.fromJson(String source) => 
      LocalUser.fromMap(json.decode(source));
}

class LocalAuthService extends ChangeNotifier {
  static final LocalAuthService _instance = LocalAuthService._internal();
  final LocalDatabaseService _db = LocalDatabaseService();
  
  // Current user
  LocalUser? _currentUser;
  LocalUser? get currentUser => _currentUser;
  
  // Authentication state
  bool get isAuthenticated => _currentUser != null;
  
  factory LocalAuthService() {
    return _instance;
  }
  
  LocalAuthService._internal();
  
  /// Initialize the auth service and load the current user from SharedPreferences
  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('currentUser');
      if (userData != null) {
        _currentUser = LocalUser.fromJson(userData);
        notifyListeners();
      }
    } catch (e) {
      print('Error initializing auth: $e');
    }
  }
  
  /// Validate email format to ensure it ends with @gmail.com
  bool _validateEmail(String email) {
    return email.toLowerCase().endsWith('@gmail.com');
  }
  
  /// Sign in with email and password
  Future<LocalUser?> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Validate email format
      if (!_validateEmail(email)) {
        throw 'Email must be a valid Gmail address (@gmail.com)';
      }
      
      // Get all users 
      final users = await _db.getCollection('users');
      
      // Find user with matching email and password
      LocalUser? matchedUser;
      
      for (var entry in users.entries) {
        final user = entry.value as Map<String, dynamic>;
        if (user['email'] == email && user['password'] == password) {
          matchedUser = LocalUser(
            uid: entry.key,
            email: user['email'],
            displayName: user['displayName'],
            photoURL: user['photoURL'],
          );
          break;
        }
      }
      
      if (matchedUser == null) {
        throw 'Invalid email or password';
      }
      
      // Save current user
      _currentUser = matchedUser;
      
      // Store in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentUser', matchedUser.toJson());
      
      notifyListeners();
      return matchedUser;
    } catch (e) {
      throw e.toString();
    }
  }
  
  /// Create a new user with email and password
  Future<LocalUser> createUserWithEmailAndPassword(String email, String password, {
    String? displayName,
    String? photoURL,
  }) async {
    try {
      // Validate email format
      if (!_validateEmail(email)) {
        throw 'Email must be a valid Gmail address (@gmail.com)';
      }
      
      // Check if email already exists
      final users = await _db.getCollection('users');
      
      for (var user in users.values) {
        if ((user as Map<String, dynamic>)['email'] == email) {
          throw 'Email already in use';
        }
      }
      
      // Create new user
      final uid = DateTime.now().millisecondsSinceEpoch.toString();
      final newUser = LocalUser(
        uid: uid,
        email: email,
        displayName: displayName,
        photoURL: photoURL,
      );
      
      // Save user in database
      await _db.saveUser(uid, {
        ...newUser.toMap(),
        'password': password,
      });
      
      // Set as current user
      _currentUser = newUser;
      
      // Store in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentUser', newUser.toJson());
      
      notifyListeners();
      return newUser;
    } catch (e) {
      throw e.toString();
    }
  }
  
  /// Reset user password
  Future<void> resetPassword(String email, String newPassword, {String? currentPassword}) async {
    try {
      // Validate email format
      if (!_validateEmail(email)) {
        throw 'Email must be a valid Gmail address (@gmail.com)';
      }
      
      // Get all users
      final users = await _db.getCollection('users');
      
      // Find user with matching email
      String? userUid;
      Map<String, dynamic>? userData;
      
      for (var entry in users.entries) {
        final user = entry.value as Map<String, dynamic>;
        if (user['email'] == email) {
          userUid = entry.key;
          userData = user;
          break;
        }
      }
      
      if (userUid == null || userData == null) {
        throw 'No account found with this email address';
      }
      
      // If current password is provided, verify it
      if (currentPassword != null) {
        if (userData['password'] != currentPassword) {
          throw 'Current password is incorrect';
        }
      }
      
      // Update the password
      userData['password'] = newPassword;
      
      // Save updated user data
      await _db.saveUser(userUid, userData);
      
      // If this is the current user, update their info in SharedPreferences
      if (_currentUser != null && _currentUser!.email == email) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('currentUser', _currentUser!.toJson());
      }
      
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }
  
  /// Sign out the current user
  Future<void> signOut() async {
    try {
      _currentUser = null;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('currentUser');
      
      notifyListeners();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
  
  /// Update user profile
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      if (_currentUser == null) {
        throw 'No user logged in';
      }
      
      // Get existing user data
      final userData = await _db.getUser(_currentUser!.uid);
      if (userData == null) {
        throw 'User not found';
      }
      
      // Update fields
      if (displayName != null) userData['displayName'] = displayName;
      if (photoURL != null) userData['photoURL'] = photoURL;
      
      // Save updated user
      await _db.saveUser(_currentUser!.uid, userData);
      
      // Update current user
      _currentUser = LocalUser(
        uid: _currentUser!.uid,
        email: _currentUser!.email,
        displayName: displayName ?? _currentUser!.displayName,
        photoURL: photoURL ?? _currentUser!.photoURL,
      );
      
      // Update in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentUser', _currentUser!.toJson());
      
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }
} 