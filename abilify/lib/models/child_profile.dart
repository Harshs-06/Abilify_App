import 'dart:convert';

class ChildProfile {
  final String name;
  final int age;
  final int points;
  final List<String> badges;
  final List<String> preferredActivities;

  ChildProfile({
    required this.name,
    required this.age,
    this.points = 0,
    this.badges = const [],
    this.preferredActivities = const [],
  });

  // Convert profile to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'points': points,
      'badges': badges,
      'preferred_activities': preferredActivities,
    };
  }

  // Create a profile from a Map
  factory ChildProfile.fromMap(Map<String, dynamic> map) {
    return ChildProfile(
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      points: map['points'] ?? 0,
      badges: List<String>.from(map['badges'] ?? []),
      preferredActivities: List<String>.from(map['preferred_activities'] ?? []),
    );
  }

  // Convert to JSON
  String toJson() => json.encode(toMap());

  // Create from JSON
  factory ChildProfile.fromJson(String source) => 
      ChildProfile.fromMap(json.decode(source));

  // Create an empty profile
  factory ChildProfile.empty() {
    return ChildProfile(
      name: '',
      age: 0,
    );
  }

  // Create a copy with updated fields
  ChildProfile copyWith({
    String? name,
    int? age,
    int? points,
    List<String>? badges,
    List<String>? preferredActivities,
  }) {
    return ChildProfile(
      name: name ?? this.name,
      age: age ?? this.age,
      points: points ?? this.points,
      badges: badges ?? this.badges,
      preferredActivities: preferredActivities ?? this.preferredActivities,
    );
  }

  // Add points to the profile
  ChildProfile addPoints(int amount) {
    return copyWith(points: points + amount);
  }

  // Add a badge to the profile
  ChildProfile addBadge(String badgeId) {
    if (badges.contains(badgeId)) return this;
    final updatedBadges = List<String>.from(badges)..add(badgeId);
    return copyWith(badges: updatedBadges);
  }
} 