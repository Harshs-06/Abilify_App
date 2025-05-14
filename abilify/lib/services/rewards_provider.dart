import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class RewardsProvider with ChangeNotifier {
  static final RewardsProvider _instance = RewardsProvider._internal();
  
  factory RewardsProvider() {
    return _instance;
  }
  
  RewardsProvider._internal();
  
  // Rewards data
  int _points = 0;
  List<String> _purchasedItems = [];
  
  // Getters
  int get points => _points;
  List<String> get purchasedItems => _purchasedItems;
  
  // Initialize from SharedPreferences
  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      _points = prefs.getInt('rewardPoints') ?? 100; // Start with 100 points
      _purchasedItems = prefs.getStringList('purchasedItems') ?? [];
      notifyListeners();
    } catch (e) {
      print('Error initializing rewards data: $e');
    }
  }
  
  // Add points
  Future<void> addPoints(int amount) async {
    _points += amount;
    await _saveData();
    notifyListeners();
  }
  
  // Spend points
  Future<bool> spendPoints(int amount) async {
    if (_points < amount) {
      return false;
    }
    
    _points -= amount;
    await _saveData();
    notifyListeners();
    return true;
  }
  
  // Add purchased item
  Future<void> addPurchasedItem(String itemId) async {
    if (!_purchasedItems.contains(itemId)) {
      _purchasedItems.add(itemId);
      await _saveData();
      notifyListeners();
    }
  }
  
  // Check if item is purchased
  bool isItemPurchased(String itemId) {
    return _purchasedItems.contains(itemId);
  }
  
  // Reset purchased items (for testing)
  Future<void> resetPurchasedItems() async {
    _purchasedItems = [];
    _points = 100; // Reset to 100 points
    await _saveData();
    notifyListeners();
  }
  
  // Save data to SharedPreferences
  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setInt('rewardPoints', _points);
      await prefs.setStringList('purchasedItems', _purchasedItems);
    } catch (e) {
      print('Error saving rewards data: $e');
    }
  }
} 