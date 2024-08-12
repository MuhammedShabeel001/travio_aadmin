import 'package:flutter/material.dart';
import 'package:travio_admin/view/pages/product/package/add_package_page.dart';

import '../../../widgets/global/search_bar.dart';

class PackagePage extends StatelessWidget {
  const PackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TSearchBar(
              hint: 'Search by package',
              controller: TextEditingController(),
              onChanged: (value) {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TripPackageDetailsPage(),
              ));
        },
        backgroundColor: Colors.orange,
        tooltip: 'Add Package',
        child: const Icon(Icons.add),
      ),
    );
  }
}
