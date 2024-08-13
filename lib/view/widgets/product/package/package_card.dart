import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/package_provider.dart';
// import '../../../../controller/trip_package_provider.dart';
import '../../../../model/package_model.dart';
import '../../../pages/product/package/package_detail_page.dart';
// import '../../../../model/trip_package_model.dart';
// import '../../../pages/trip_package/trip_package_detail_page.dart';

class TripPackageCard extends StatelessWidget {
  final TripPackageModel tripPackage;

  const TripPackageCard({Key? key, required this.tripPackage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tripPackageProvider = Provider.of<TripPackageProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripPackageDetailPage(tripPackage: tripPackage),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    tripPackage.images.isNotEmpty ? tripPackage.images.first : 'https://via.placeholder.com/150',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${tripPackage.images.length} Images',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tripPackage.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${tripPackage.numberOfDays} Days, ${tripPackage.numberOfNights} Nights',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tripPackage.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, color: Colors.orange),
                      ),
                      IconButton(
                        onPressed: () {
                          showDeleteConfirmationDialog(tripPackageProvider, tripPackage.id);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(
      TripPackageProvider tripPackageProvider, String tripPackageId) {
    BotToast.showCustomNotification(
      toastBuilder: (cancelFunc) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Delete Trip Package',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Are you sure you want to delete this trip package?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      cancelFunc();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // cancelFunc();
                      // tripPackageProvider.deleteTripPackage(tripPackageId);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      duration: null,
      onlyOne: true,
      backButtonBehavior: BackButtonBehavior.none,
      crossPage: true,
    );
  }
}
