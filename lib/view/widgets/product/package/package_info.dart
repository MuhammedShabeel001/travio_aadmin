import 'package:flutter/material.dart';
import 'package:travio_admin/model/package_model.dart';

class PackageInfoWidget extends StatelessWidget {
  final TripPackageModel tripPackage;

  const PackageInfoWidget({Key? key, required this.tripPackage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tripPackage.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.red),
              onPressed: () {
                // Handle favorite action
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          tripPackage.description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Text(
                '\$${tripPackage.realPrice}',
                style: const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${tripPackage.offerPrice}',
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Daily Plan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Divider(),
        Column(
          children: tripPackage.dailyPlan.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Day ${entry.key}: ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        const Text(
          'Activities',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Divider(),
        Text(
          tripPackage.activities.join(', '),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Transport Options',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Divider(),
        Text(
          tripPackage.transportOptions.join(', '),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
