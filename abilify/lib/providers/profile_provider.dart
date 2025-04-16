import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:abilify/models/parent_profile.dart';
import 'package:abilify/models/child_profile.dart';
import 'package:abilify/utils/constants.dart';

class ProfileProvider extends ChangeNotifier {
  ParentProfile? _parentProfile;
  ChildProfile? _childProfile;
  ProfileType _currentProfileType = ProfileType.parent;
  bool _isLoading = true;

  // Getters
  ParentProfile get parentProfile => 
      _parentProfile ?? ParentProfile.empty();
  
  ChildProfile get childProfile => 
      _childProfile ?? ChildProfile.empty();
  
  ProfileType get currentProfileType => _currentProfileType;
  
  bool get isLoading => _isLoading;
  
  bool get hasParentProfile => _parentProfile != null;
  
  bool get hasChildProfile => _childProfile != null;

  // Initialize profiles from SharedPreferences
  Future<void> initProfiles() async {
    _isLoading = true;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    
    // Load parent profile
    final parentProfileJson = prefs.getString(kParentProfileKey);
    if (parentProfileJson != null) {
      _parentProfile = ParentProfile.fromJson(parentProfileJson);
    }
    
    // Load child profile
    final childProfileJson = prefs.getString(kChildProfileKey);
    if (childProfileJson != null) {
      _childProfile = ChildProfile.fromJson(childProfileJson);
    }
    
    // Load current profile type
    final profileTypeIndex = prefs.getInt(kCurrentProfileTypeKey);
    if (profileTypeIndex != null) {
      _currentProfileType = ProfileType.values[profileTypeIndex];
    }
    
    _isLoading = false;
    notifyListeners();
  }

  // Save parent profile
  Future<void> saveParentProfile(ParentProfile profile) async {
    _parentProfile = profile;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kParentProfileKey, profile.toJson());
  }

  // Save child profile
  Future<void> saveChildProfile(ChildProfile profile) async {
    _childProfile = profile;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kChildProfileKey, profile.toJson());
  }

  // Set current profile type
  Future<void> setCurrentProfileType(ProfileType type) async {
    _currentProfileType = type;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(kCurrentProfileTypeKey, type.index);
  }

  // Add points to child profile
  Future<void> addPoints(int amount) async {
    if (_childProfile == null) return;
    
    final updatedProfile = _childProfile!.addPoints(amount);
    await saveChildProfile(updatedProfile);
    
    // Check for new badges
    _checkForNewBadges();
  }

  // Add badge to child profile
  Future<void> addBadge(String badgeId) async {
    if (_childProfile == null) return;
    
    final updatedProfile = _childProfile!.addBadge(badgeId);
    await saveChildProfile(updatedProfile);
  }

  // Check for new badges based on points
  void _checkForNewBadges() {
    if (_childProfile == null) return;
    
    final points = _childProfile!.points;
    
    // Star Player badge (50 points)
    if (points >= 50 && !_childProfile!.badges.contains('star_player')) {
      addBadge('star_player');
    }
    
    // Super Helper badge (100 points)
    if (points >= 100 && !_childProfile!.badges.contains('super_helper')) {
      addBadge('super_helper');
    }
  }

  // Log therapy session
  Future<void> logTherapySession(Map<String, dynamic> session) async {
    if (_parentProfile == null) return;
    
    final therapyLogs = List<Map<String, dynamic>>.from(_parentProfile!.therapyLogs);
    therapyLogs.add(session);
    
    final updatedProfile = _parentProfile!.copyWith(therapyLogs: therapyLogs);
    await saveParentProfile(updatedProfile);
  }

  // Add bookmark
  Future<void> addBookmark(String resourceId) async {
    if (_parentProfile == null) return;
    
    if (_parentProfile!.bookmarks.contains(resourceId)) return;
    
    final bookmarks = List<String>.from(_parentProfile!.bookmarks);
    bookmarks.add(resourceId);
    
    final updatedProfile = _parentProfile!.copyWith(bookmarks: bookmarks);
    await saveParentProfile(updatedProfile);
  }

  // Remove bookmark
  Future<void> removeBookmark(String resourceId) async {
    if (_parentProfile == null) return;
    
    final bookmarks = List<String>.from(_parentProfile!.bookmarks);
    bookmarks.remove(resourceId);
    
    final updatedProfile = _parentProfile!.copyWith(bookmarks: bookmarks);
    await saveParentProfile(updatedProfile);
  }
} 