import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/view/widgets/product/package/review_card.dart';

import '../../../../controller/review_provider.dart';
import '../../../../model/package_model.dart';

class ReviewsTab extends StatelessWidget {
  final TripPackageModel tripPackage;

  const ReviewsTab({Key? key, required this.tripPackage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String packageId = tripPackage.id;

    return Consumer<ReviewProvider>(
      builder: (context, reviewProvider, _) {
        return FutureBuilder(
          future: reviewProvider
              .fetchReviews(packageId), // Fetching reviews based on packageId
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // You can display a loading spinner here
              // return const Center(child: CircularProgressIndicator());
            }

            final reviews = reviewProvider.reviews; // Get the fetched reviews

            // If there are no reviews, display a 'no reviews' animation
            if (reviews.isEmpty) {
              return SizedBox(
                height: 30,
                child: Center(
                  child: Lottie.asset(
                      'assets/animations/empty_review.json'), // No reviews animation
                ),
              );
            }

            // If reviews exist, display them in a ListView
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index]; // Each review from the list
                return ReviewCard(
                  userName: review.userName,
                  // userProfileUrl: 'assets/images/default_pfpf.jpg',
                  review: review.reviewText,
                  rating: review.rating, // Pass rating value
                );
              },
            );
          },
        );
      },
    );
  }
}
