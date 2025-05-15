import 'package:abilify/models/reward_item.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  static final CartProvider _instance = CartProvider._internal();
  
  factory CartProvider() {
    return _instance;
  }
  
  CartProvider._internal();
  
  // Cart items
  final List<RewardItem> _cartItems = [];
  final Set<String> _selectedItemIds = {};
  
  // Getters
  List<RewardItem> get cartItems => _cartItems;
  Set<String> get selectedItemIds => _selectedItemIds;
  
  // Check if item is in cart
  bool isInCart(String itemId) {
    return _cartItems.any((item) => item.id == itemId);
  }
  
  // Check if item is selected
  bool isSelected(String itemId) {
    return _selectedItemIds.contains(itemId);
  }
  
  // Add item to cart
  void addToCart(RewardItem item) {
    if (!isInCart(item.id)) {
      _cartItems.add(item);
      // Auto-select newly added items
      _selectedItemIds.add(item.id);
      notifyListeners();
    }
  }
  
  // Remove item from cart
  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    _selectedItemIds.remove(itemId);
    notifyListeners();
  }
  
  // Toggle item selection
  void toggleSelection(String itemId) {
    if (_selectedItemIds.contains(itemId)) {
      _selectedItemIds.remove(itemId);
    } else {
      _selectedItemIds.add(itemId);
    }
    notifyListeners();
  }
  
  // Toggle all items selection
  void toggleSelectAll() {
    if (_selectedItemIds.length == _cartItems.length) {
      // If all selected, deselect all
      _selectedItemIds.clear();
    } else {
      // Select all
      _selectedItemIds.clear();
      for (var item in _cartItems) {
        _selectedItemIds.add(item.id);
      }
    }
    notifyListeners();
  }
  
  // Get total points for selected items
  int get totalSelectedPoints {
    int total = 0;
    for (var item in _cartItems) {
      if (_selectedItemIds.contains(item.id)) {
        total += item.points;
      }
    }
    return total;
  }
  
  // Get selected items
  List<RewardItem> get selectedItems {
    return _cartItems.where((item) => _selectedItemIds.contains(item.id)).toList();
  }
  
  // Clear cart
  void clearCart() {
    _cartItems.clear();
    _selectedItemIds.clear();
    notifyListeners();
  }
} 