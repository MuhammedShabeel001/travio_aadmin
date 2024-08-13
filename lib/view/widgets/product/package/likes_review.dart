import 'package:flutter/material.dart';
import 'package:travio_admin/model/package_model.dart';

class LikesAndReviewsWidget extends StatelessWidget {
  final TripPackageModel tripPackage;

  const LikesAndReviewsWidget({Key? key, required this.tripPackage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.favorite, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              '${tripPackage.likeCount} Likes',
              style: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber),
            const SizedBox(width: 8),
            Text(
              '${tripPackage.bookedCount} Reviews',
              style: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ],
    );
  }
}
