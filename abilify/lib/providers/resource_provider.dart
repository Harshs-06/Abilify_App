import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:abilify/models/resource.dart';
import 'package:abilify/utils/constants.dart';
import 'package:abilify/utils/mock_data.dart';

class ResourceProvider extends ChangeNotifier {
  List<Resource> _resources = [];
  bool _isLoading = true;
  String _selectedCategory = '';

  // Getters
  List<Resource> get resources => _resources;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;

  // Filtered resources by category
  List<Resource> getResourcesByCategory(String category) {
    if (category.isEmpty) return _resources;
    return _resources.where((res) => res.category == category).toList();
  }

  // Get resources by type
  List<Resource> getResourcesByType(String type) {
    return _resources.where((res) => res.type == type).toList();
  }

  // Initialize resources
  Future<void> initResources() async {
    _isLoading = true;
    notifyListeners();

    // In a real app, we would load resources from a server
    // For now, we'll use mock data
    try {
      final prefs = await SharedPreferences.getInstance();
      final resourcesJson = prefs.getString(kResourcesKey);

      if (resourcesJson != null) {
        final List<dynamic> decodedResources = json.decode(resourcesJson);
        _resources = decodedResources
            .map((resource) => Resource.fromMap(resource))
            .toList();
      } else {
        // If no saved resources, use mock data
        _resources = getResources();
        // Save mock data to preferences
        await saveResources();
      }
    } catch (e) {
      // If there's an error, fallback to mock data
      _resources = getResources();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Save resources to SharedPreferences
  Future<void> saveResources() async {
    final prefs = await SharedPreferences.getInstance();
    final resourcesJson = json.encode(
        _resources.map((resource) => resource.toMap()).toList());
    await prefs.setString(kResourcesKey, resourcesJson);
  }

  // Set selected category
  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Add a new resource
  Future<void> addResource(Resource resource) async {
    _resources.add(resource);
    notifyListeners();
    await saveResources();
  }

  // Update an existing resource
  Future<void> updateResource(Resource updatedResource) async {
    final index = _resources.indexWhere((res) => res.id == updatedResource.id);
    if (index != -1) {
      _resources[index] = updatedResource;
      notifyListeners();
      await saveResources();
    }
  }

  // Delete a resource
  Future<void> deleteResource(String resourceId) async {
    _resources.removeWhere((res) => res.id == resourceId);
    notifyListeners();
    await saveResources();
  }

  // Get resource by ID
  Resource? getResourceById(String id) {
    try {
      return _resources.firstWhere((res) => res.id == id);
    } catch (e) {
      return null;
    }
  }
} 