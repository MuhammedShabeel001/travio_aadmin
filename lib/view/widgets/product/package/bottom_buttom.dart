import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/model/package_model.dart';
import 'package:travio_admin/view/widgets/global/delete_dialog.dart';
// import 'package:travio_admin/view/widgets/product/package/edit_package_page.dart';
import '../../../../controller/package_provider.dart';

class BookButton extends StatelessWidget {
  final TripPackageModel tripPackage;
  final String tripPackageId; // Pass the trip package ID from the parent widget

  const  BookButton({super.key, required this.tripPackageId, required this.tripPackage});

  @override
  Widget build(BuildContext context) {
    // Fetch the provider
    final tripPackageProvider = Provider.of<TripPackageProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Flexible(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Call the delete confirmation dialog
              showDeleteConfirmationDialog(context, tripPackageProvider, tripPackageId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.delete, color: Colors.white),
                SizedBox(width: 10),
                Text('Delete', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
