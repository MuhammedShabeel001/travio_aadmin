import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String id;
  final String userId;
  final String reviewText;
  final double rating;
  final DateTime timestamp;
  final String userName;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.reviewText,
    required this.rating,
    required this.timestamp,
    required this.userName,
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map, String id) {
    return ReviewModel(
      id: id,
      userId: map['userId'] as String,
      reviewText: map['reviewText'] as String,
      rating: (map['rating'] as num).toDouble(),
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      userName: map['userName'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'reviewText': reviewText,
      'rating': rating,
      'timestamp': Timestamp.fromDate(timestamp),
      'userName': userName,
    };
  }
}
