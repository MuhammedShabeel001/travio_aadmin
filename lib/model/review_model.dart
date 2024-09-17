import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String id;
  final String userId;
  final String reviewText;
  final double rating;
  final DateTime timestamp;
  final String userName; // New field for user's name
  // final String profileImageUrl; // New field for user's profile image

  ReviewModel({
    required this.id,
    required this.userId,
    required this.reviewText,
    required this.rating,
    required this.timestamp,
    required this.userName, // Initialize this
    // required this.profileImageUrl, // Initialize this
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map, String id) {
    return ReviewModel(
      id: id,
      userId: map['userId'] as String,
      reviewText: map['reviewText'] as String,
      rating: (map['rating'] as num).toDouble(),
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      userName: map['userName'] as String, // Fetch user's name
      // profileImageUrl: map['profileImageUrl'] as String, // Fetch user's profile image URL
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'reviewText': reviewText,
      'rating': rating,
      'timestamp': Timestamp.fromDate(timestamp),
      'userName': userName, // Include user's name
      // 'profileImageUrl': profileImageUrl, // Include user's profile image URL
    };
  }
}
