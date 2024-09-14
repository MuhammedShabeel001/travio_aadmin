import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
import 'package:travio_admin/controller/package_provider.dart';
import 'package:travio_admin/view/pages/product/package/add_package_page.dart';
import 'package:travio_admin/view/widgets/product/package/package_card.dart';

import '../../../widgets/global/search_bar.dart';

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
                    return Center(
                      child: SvgPicture.asset('assets/icons/empty.svg'),
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
