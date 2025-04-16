import 'dart:convert';

class ParentProfile {
  final String name;
  final String email;
  final Map<String, dynamic> child;
  final List<String> bookmarks;
  final List<Map<String, dynamic>> therapyLogs;

  ParentProfile({
    required this.name,
    required this.email,
    required this.child,
    this.bookmarks = const [],
    this.therapyLogs = const [],
  });

  // Convert profile to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'child': child,
      'bookmarks': bookmarks,
      'therapy_logs': therapyLogs,
    };
  }

  // Create a profile from a Map
  factory ParentProfile.fromMap(Map<String, dynamic> map) {
    return ParentProfile(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      child: map['child'] ?? {},
      bookmarks: List<String>.from(map['bookmarks'] ?? []),
      therapyLogs: List<Map<String, dynamic>>.from(map['therapy_logs'] ?? []),
    );
  }

  // Convert to JSON
  String toJson() => json.encode(toMap());

  // Create from JSON
  factory ParentProfile.fromJson(String source) => 
      ParentProfile.fromMap(json.decode(source));

  // Create an empty profile
  factory ParentProfile.empty() {
    return ParentProfile(
      name: '',
      email: '',
      child: {
        'name': '',
        'age': 0,
        'needs': [],
      },
    );
  }

  // Create a copy with updated fields
  ParentProfile copyWith({
    String? name,
    String? email,
    Map<String, dynamic>? child,
    List<String>? bookmarks,
    List<Map<String, dynamic>>? therapyLogs,
  }) {
    return ParentProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      child: child ?? this.child,
      bookmarks: bookmarks ?? this.bookmarks,
      therapyLogs: therapyLogs ?? this.therapyLogs,
    );
  }
} 