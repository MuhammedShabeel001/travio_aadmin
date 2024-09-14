import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travio_admin/view/widgets/product/package/review_card.dart';

import '../../../../model/package_model.dart';

class ReviewsTab extends StatelessWidget {
  final TripPackageModel tripPackage;

  const ReviewsTab({Key? key, required this.tripPackage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviews = tripPackage.customerReviews;

    if (reviews.isEmpty) {
      return SizedBox(
          height: 30,
          child: Center(
              child: Lottie.asset('assets/animations/empty_review.json')));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final userId = reviews.keys.elementAt(index);
        final reviewText = reviews[userId] ?? '';

        return ReviewCard(
          userName:
              '$userId', // You might want to fetch the actual username if available
          userProfileUrl:
              'assets/image/default_pfpf.jpg', // Placeholder image, replace with actual user image if available
          review: reviewText,
        );
      },
    );
  }
}
