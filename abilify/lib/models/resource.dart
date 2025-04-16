import 'dart:convert';

class Resource {
  final String id;
  final String title;
  final String category;
  final String type; // 'article', 'video', 'guide'
  final String content;
  final String? url;
  final String? imageUrl;

  Resource({
    required this.id,
    required this.title,
    required this.category,
    required this.type,
    this.content = '',
    this.url,
    this.imageUrl,
  });

  // Convert resource to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'type': type,
      'content': content,
      'url': url,
      'image_url': imageUrl,
    };
  }

  // Create a resource from a Map
  factory Resource.fromMap(Map<String, dynamic> map) {
    return Resource(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      type: map['type'] ?? '',
      content: map['content'] ?? '',
      url: map['url'],
      imageUrl: map['image_url'],
    );
  }

  // Convert to JSON
  String toJson() => json.encode(toMap());

  // Create from JSON
  factory Resource.fromJson(String source) => 
      Resource.fromMap(json.decode(source));

  // List of valid resource types
  static const List<String> validTypes = ['article', 'video', 'guide'];
  
  // List of valid resource categories
  static const List<String> validCategories = [
    'sensory', 
    'speech', 
    'occupational',
    'behavioral',
    'educational',
    'parenting',
  ];
} 