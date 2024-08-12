import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travio_admin/controller/place_provider.dart';
import 'package:travio_admin/view/pages/product/location/add_location_page.dart';

import '../../../widgets/global/search_bar.dart';
import '../../../widgets/product/location/detail_card.dart';
// import 'package:travio_admin/view/widgets/global/search_bar.dart';
// import 'package:travio_admin/view/widgets/product/location/detail_card.dart';
// import 'package:travio_admin/controller/place_provider.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);

    // Fetch locations when the widget is built for the first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      placeProvider.fetchAllLocations();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TSearchBar(
                hint: 'Search by location name, country, continent, or activity',
                controller: placeProvider.searchController,
                onChanged: (value) {
                  placeProvider.updateSearchQuery(value);
                },
              ),
            ),
            Expanded(
              child: Consumer<PlaceProvider>(
                builder: (context, placeProvider, child) {
                  if (placeProvider.filteredPlaces.isEmpty) {
                    return ListView.builder(
                      itemCount: 5, // Number of shimmer placeholders
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Color.fromARGB(255, 255, 248, 226),
                          highlightColor: Colors.grey[100]!,
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                      itemCount: placeProvider.filteredPlaces.length,
                      itemBuilder: (context, index) {
                        return DetailCard(place: placeProvider.filteredPlaces[index]);
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
          // Add location action
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddLocation(),));
        },
        backgroundColor: Colors.orange,
        tooltip: 'Add Location',
        child: const Icon(Icons.add),
      ),
    );
  }
}
