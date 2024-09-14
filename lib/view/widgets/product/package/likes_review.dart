import 'package:flutter/material.dart';
import 'package:travio_admin/model/package_model.dart';

class LikesAndReviewsWidget extends StatelessWidget {
  final TripPackageModel tripPackage;

  const LikesAndReviewsWidget({super.key, required this.tripPackage});

  @override
  Widget build(BuildContext context) {
    return Row(
      
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
       
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
