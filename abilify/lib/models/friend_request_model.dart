import 'package:flutter/material.dart';

enum RequestStatus {
  pending,
  accepted,
  rejected
}

class FriendRequest {
  final String id;
  final String senderId;
  final String senderName;
  final String? senderImage;
  final String receiverId;
  final String receiverName;
  final String? receiverImage;
  final DateTime requestTime;
  RequestStatus status;
  
  FriendRequest({
    required this.id,
    required this.senderId,
    required this.senderName,
    this.senderImage,
    required this.receiverId,
    required this.receiverName,
    this.receiverImage,
    required this.requestTime,
    this.status = RequestStatus.pending,
  });
}

// Mock users that can be found through search
class UserProfile {
  final String id;
  final String name;
  final String? image;
  final String userType; // 'parent', 'child', 'professional'
  final String? specialization; // Only for professionals
  final String? bio;
  bool isFriend;
  bool hasRequestPending;
  
  UserProfile({
    required this.id,
    required this.name,
    this.image,
    required this.userType,
    this.specialization,
    this.bio,
    this.isFriend = false,
    this.hasRequestPending = false,
  });
}

// Mock parent profiles
List<UserProfile> mockParentProfiles = [
  UserProfile(
    id: 'p1',
    name: 'Lisa Wong',
    image: 'assets/parent1.png',
    userType: 'parent',
    bio: 'Mom of two, with a 7-year-old on the spectrum',
    isFriend: true,
  ),
  UserProfile(
    id: 'p2',
    name: 'Mark Johnson',
    image: 'assets/parent2.png',
    userType: 'parent',
    bio: 'Father of a daughter with special needs',
    isFriend: true,
  ),
  UserProfile(
    id: 'p3',
    name: 'Amanda Chen',
    image: 'assets/parent3.png',
    userType: 'parent',
    bio: 'Parent advocate, son with ADHD and dyslexia',
    isFriend: false,
  ),
  UserProfile(
    id: 'p4',
    name: 'Robert Martinez',
    image: 'assets/parent4.png',
    userType: 'parent',
    bio: 'Dad of twins, one with developmental delays',
    isFriend: false,
  ),
  UserProfile(
    id: 'p5',
    name: 'Priya Sharma',
    image: 'assets/parent5.png',
    userType: 'parent',
    bio: 'Mother of 8-year-old with sensory processing disorder',
    isFriend: false,
    hasRequestPending: true,
  ),
  UserProfile(
    id: 'p6',
    name: 'James Wilson',
    image: 'assets/profile_p2.png',
    userType: 'parent',
    bio: 'Father of a child with autism, support group leader',
    isFriend: false,
  ),
  UserProfile(
    id: 'p7',
    name: 'Sarah Miller',
    image: null,
    userType: 'parent',
    bio: 'Mom of three, one with special needs',
    isFriend: false,
  ),
  UserProfile(
    id: 'p8',
    name: 'David Thompson',
    image: null,
    userType: 'parent',
    bio: 'Father advocating for inclusive education',
    isFriend: false,
  ),
  UserProfile(
    id: 'p9',
    name: 'Maria Rodriguez',
    image: null,
    userType: 'parent',
    bio: 'Mother of a child with Down syndrome',
    isFriend: false,
  ),
  UserProfile(
    id: 'p10',
    name: 'John Lee',
    image: null,
    userType: 'parent',
    bio: 'Dad of a child with ADHD',
    isFriend: false,
  ),
];

// Mock child profiles
List<UserProfile> mockChildProfiles = [
  UserProfile(
    id: 'c1',
    name: 'Alex',
    image: 'assets/child1.png',
    userType: 'child',
    bio: 'I like space games and robots!',
    isFriend: true,
  ),
  UserProfile(
    id: 'c2',
    name: 'Taylor',
    image: 'assets/child2.png',
    userType: 'child',
    bio: 'I love drawing and dinosaurs',
    isFriend: true,
  ),
  UserProfile(
    id: 'c3',
    name: 'Sam',
    image: 'assets/child3.png',
    userType: 'child',
    bio: 'I enjoy reading books about animals',
    isFriend: false,
  ),
  UserProfile(
    id: 'c4',
    name: 'Jordan',
    image: 'assets/child4.png',
    userType: 'child',
    bio: 'I like to play soccer and video games',
    isFriend: false,
  ),
  UserProfile(
    id: 'c5',
    name: 'Casey',
    image: 'assets/child5.png',
    userType: 'child',
    bio: 'I love music and playing drums',
    isFriend: false,
    hasRequestPending: true,
  ),
  UserProfile(
    id: 'c6',
    name: 'Riley',
    image: null,
    userType: 'child',
    bio: 'I like building with LEGOs and playing games',
    isFriend: false,
  ),
  UserProfile(
    id: 'c7',
    name: 'Jamie',
    image: null,
    userType: 'child',
    bio: 'I enjoy swimming and art projects',
    isFriend: false,
  ),
  UserProfile(
    id: 'c8',
    name: 'Morgan',
    image: null,
    userType: 'child',
    bio: 'I like to draw comics and read',
    isFriend: false,
  ),
  UserProfile(
    id: 'c9',
    name: 'Avery',
    image: null,
    userType: 'child',
    bio: 'I love science experiments and nature',
    isFriend: false,
  ),
  UserProfile(
    id: 'c10',
    name: 'Quinn',
    image: null,
    userType: 'child',
    bio: 'I like basketball and coding games',
    isFriend: false,
  ),
];

// Mock professional profiles
List<UserProfile> mockProfessionalProfiles = [
  UserProfile(
    id: 'pr1',
    name: 'Dr. Sarah Miller',
    image: 'assets/story_time.png',
    userType: 'professional',
    specialization: 'Developmental Pediatrician',
    bio: 'Specializing in developmental disorders for 15 years',
    isFriend: true,
  ),
  UserProfile(
    id: 'pr2',
    name: 'Dr. James Wilson',
    image: 'assets/dr_james.png',
    userType: 'professional',
    specialization: 'Child Psychologist',
    bio: 'Expertise in behavioral therapy and emotional development',
    isFriend: false,
  ),
  UserProfile(
    id: 'pr3',
    name: 'Melissa Parker',
    image: 'assets/therapist1.png',
    userType: 'professional',
    specialization: 'Speech Therapist',
    bio: '10+ years helping children with communication challenges',
    isFriend: false,
  ),
];

// Mock pending friend requests
List<FriendRequest> mockPendingRequests = [
  FriendRequest(
    id: 'fr1',
    senderId: 'p5',
    senderName: 'Priya Sharma',
    senderImage: 'assets/parent5.png',
    receiverId: 'current_parent',
    receiverName: 'Palak',
    receiverImage: 'assets/profile_p2.png',
    requestTime: DateTime.now().subtract(Duration(days: 1)),
  ),
  FriendRequest(
    id: 'fr2',
    senderId: 'pr2',
    senderName: 'Dr. James Wilson',
    senderImage: 'assets/dr_james.png',
    receiverId: 'current_parent',
    receiverName: 'Palak',
    receiverImage: 'assets/profile_p2.png',
    requestTime: DateTime.now().subtract(Duration(hours: 5)),
  ),
];

// Mock pending friend requests for child
List<FriendRequest> mockChildPendingRequests = [
  FriendRequest(
    id: 'fr3',
    senderId: 'c5',
    senderName: 'Casey',
    senderImage: 'assets/child5.png',
    receiverId: 'current_child',
    receiverName: 'Jade',
    receiverImage: 'assets/child_pf.png',
    requestTime: DateTime.now().subtract(Duration(hours: 8)),
  ),
  FriendRequest(
    id: 'fr4',
    senderId: 'c4',
    senderName: 'Jordan',
    senderImage: 'assets/child4.png',
    receiverId: 'current_child',
    receiverName: 'Jade',
    receiverImage: 'assets/child_pf.png',
    requestTime: DateTime.now().subtract(Duration(days: 1, hours: 2)),
  ),
]; 