// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/package_provider.dart';
// / import '../../../../controller/trip_package_provider.dart';
import '../../../../model/package_model.dart';
import '../../../pages/product/package/package_detail_page.dart';
import '../../global/delete_dialog.dart';
// import '../../../../model/trip_package_model.dart';
// import '../../../pages/trip_package/trip_package_detail_page.dart';

class TripPackageCard extends StatelessWidget {
  final TripPackageModel tripPackage;
  double? height;

   TripPackageCard({
    super.key,
    required this.tripPackage,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final tripPackageProvider =
        Provider.of<TripPackageProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TripPackageDetailPage(tripPackage: tripPackage),
          ),
        );
      },
      // onLongPress: () {
      //   showDeleteConfirmationDialog(context, tripPackageProvider, tripPackageProvider.currentPackage!.id);
      // },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        color: Colors.white,
        child: Stack(
          children: [
            // Image with gradient overlay
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.network(
                    tripPackage.images.isNotEmpty
                        ? tripPackage.images.first
                        : 'https://via.placeholder.com/150',
                    height: height ?? 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Gradient overlay
                  Container(
                    height:height ?? 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Package details on top of the image
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tripPackage.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${tripPackage.numberOfDays} Days, ${tripPackage.numberOfNights} Nights',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    tripPackage.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Actions (edit & delete) as small floating icons

            // Number of images indicator
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${tripPackage.images.length} Images',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
