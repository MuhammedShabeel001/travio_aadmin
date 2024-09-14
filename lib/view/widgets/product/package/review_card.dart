import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final String userProfileUrl;
  final String review;

  const ReviewCard({
    Key? key,
    required this.userName,
    required this.userProfileUrl,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(userProfileUrl),
                ),
                const SizedBox(width: 16.0),
                Text(
                  userName,
                  // style:text,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(review),
          ],
        ),
      ),
    );
  }
}