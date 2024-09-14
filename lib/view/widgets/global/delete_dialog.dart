import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';

import '../../../../controller/package_provider.dart';

void showDeleteConfirmationDialog(
  // bool isDetailpage,
  BuildContext context,
  TripPackageProvider tripPackageProvider,
  String tripPackageId,
) {
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
                    cancelFunc(); // Close the dialog
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
                    // Perform deletion
                    tripPackageProvider.deletePackage(tripPackageId);

                    // Close the dialog
                    cancelFunc();

                    // Navigate to the previous screen if isDetailpage is true
                    // if (isDetailpage) {
                      Navigator.pop(context);
                    // }
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
