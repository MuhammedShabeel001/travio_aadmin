import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travio_admin/controller/package_provider.dart';
import 'package:travio_admin/view/pages/product/package/add_package_page.dart';
import 'package:travio_admin/view/widgets/product/package/package_card.dart';

import '../../../widgets/global/search_bar.dart';
import '../../../widgets/product/location/detail_card.dart';

class PackagePage extends StatelessWidget {
  const PackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final packageProvider = Provider.of<TripPackageProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      packageProvider.fetchAllPackages();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TSearchBar(
                hint: 'Search by package name, or activity',
                controller: packageProvider.searchController,
                onChanged: (value) {
                  packageProvider.updateSearchQuery(value);
                },
              ),
            ),
            Expanded(
              child: Consumer<TripPackageProvider>(
                builder: (context, packageProvider, child) {
                  if (packageProvider.filteredPackages.isEmpty) {
                    return ListView.builder(
                      itemCount: 5, // Number of shimmer placeholders
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Color.fromARGB(255, 255, 248, 226),
                          highlightColor: Colors.grey[100]!,
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: packageProvider.filteredPackages.length,
                      itemBuilder: (context, index) {
                        return TripPackageCard(
                            tripPackage:
                                packageProvider.filteredPackages[index]);
                      },
                    );
                  }
                },
              ),
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
