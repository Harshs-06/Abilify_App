import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider {
  static final UserDataProvider _instance = UserDataProvider._internal();
  
  factory UserDataProvider() {
    return _instance;
  }
  
  UserDataProvider._internal();
  
  // User profile data
  String _childName = 'Super Learner';
  String _childAge = '8';
  String _profileImage = 'assets/child_pf.png';
  bool _isAssetImage = true;
  
  // Getters
  String get childName => _childName;
  String get childAge => _childAge;
  String get profileImage => _profileImage;
  bool get isAssetImage => _isAssetImage;
  
  // Initialize from SharedPreferences
  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      _childName = prefs.getString('childName') ?? 'Super Learner';
      _childAge = prefs.getString('childAge') ?? '8';
      _profileImage = prefs.getString('profileImage') ?? 'assets/child_pf.png';
      _isAssetImage = prefs.getBool('isAssetImage') ?? true;
    } catch (e) {
      print('Error initializing user data: $e');
    }
  }
  
  // Update user profile data and save to SharedPreferences
  Future<void> updateProfile({
    String? name,
    String? age,
    String? image,
    bool? isAsset,
  }) async {
    if (name != null) _childName = name;
    if (age != null) _childAge = age;
    if (image != null) _profileImage = image;
    if (isAsset != null) _isAssetImage = isAsset;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setString('childName', _childName);
      await prefs.setString('childAge', _childAge);
      await prefs.setString('profileImage', _profileImage);
      await prefs.setBool('isAssetImage', _isAssetImage);
    } catch (e) {
      print('Error saving user data: $e');
    }
  }
} 