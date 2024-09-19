import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/review_model.dart';

class ReviewProvider with ChangeNotifier {
  List<ReviewModel> reviews = [];

  Future<void> fetchReviews(String packageId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('trip_packages')
        .doc(packageId)
        .collection('reviews')
        .get();

    reviews = await Future.wait(snapshot.docs.map((doc) async {
      final data = doc.data();
      final userId = data['userId'] as String;

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      final userData = userDoc.data() as Map<String, dynamic>;

      return ReviewModel.fromMap(
        {
          ...data,
          'userName': userData['name'],
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
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    final userData = userDoc.data() as Map<String, dynamic>;

    final reviewData = {
      'userId': userId,
      'rating': rating,
      'reviewText': reviewText,
      'timestamp': FieldValue.serverTimestamp(),
      'userName': userData['name'],
    };

    final docRef = await FirebaseFirestore.instance
        .collection('trip_packages')
        .doc(packageId)
        .collection('reviews')
        .add(reviewData);

    final newReview = ReviewModel.fromMap(
      await docRef.get().then((doc) => doc.data() as Map<String, dynamic>),
      docRef.id,
    );

    reviews.add(newReview);
    notifyListeners();
  }
}
