import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/review_model.dart';
// import 'review_model.dart'; // Import your ReviewModel class

class ReviewProvider with ChangeNotifier {
  List<ReviewModel> reviews = [];

  Future<void> fetchReviews(String packageId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('trip_packages')
      .doc(packageId)
      .collection('reviews')
      .get();
      
  reviews = await Future.wait(snapshot.docs.map((doc) async {
    final data = doc.data() as Map<String, dynamic>;
    final userId = data['userId'] as String;

    // Fetch user data from users collection
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    final userData = userDoc.data() as Map<String, dynamic>;

    return ReviewModel.fromMap(
      {
        ...data,
        'userName': userData['name'], // Assuming 'name' is a field in user data
        // 'profileImageUrl': userData['profileImageUrl'], // Assuming 'profileImageUrl' is a field
      },
      doc.id,
    );
  }).toList());

  notifyListeners();
}

Future<void> submitReview({
  required String packageId,
  required String userId,
  required double rating,
  required String reviewText,
}) async {
  // Fetch user data from the 'users' collection
  final userDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .get();

  final userData = userDoc.data() as Map<String, dynamic>;

  // Include userName and profileImageUrl in the reviewData
  final reviewData = {
    'userId': userId,
    'rating': rating,
    'reviewText': reviewText,
    'timestamp': FieldValue.serverTimestamp(),
    'userName': userData['name'], // Assuming 'name' is the user's name
    // 'profileImageUrl': userData['profileImageUrl'], // Assuming 'profileImageUrl' is the user's profile image
  };

  // Add the review to Firestore
  final docRef = await FirebaseFirestore.instance
      .collection('trip_packages')
      .doc(packageId)
      .collection('reviews')
      .add(reviewData);

  // Fetch the newly created review document from Firestore
  final newReview = ReviewModel.fromMap(
    await docRef.get().then((doc) => doc.data() as Map<String, dynamic>),
    docRef.id,
  );

  // Add the new review to the list and notify listeners
  reviews.add(newReview);
  notifyListeners();
}
}
