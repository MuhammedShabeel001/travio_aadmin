import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travio_admin_/view/widgets/global/search_bar.dart';
import 'package:travio_admin_/view/widgets/product/location/detail_card.dart';
import 'package:travio_admin_/controller/place_provider.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context, listen: false);

    // Fetch locations when the widget is built for the first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      placeProvider.fetchAllLocations();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TSearchBar(
              hint: 'Search by location ',
              controller: TextEditingController(),
              onChanged: (value) {},
            ),
          ),
          Expanded(
            child: Consumer<PlaceProvider>(
              builder: (context, placeProvider, child) {
                if (placeProvider.places.isEmpty) {
                  return ListView.builder(
                    itemCount: 5, // Number of shimmer placeholders
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
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
                    itemCount: placeProvider.places.length,
                    itemBuilder: (context, index) {
                      return DetailCard(place: placeProvider.places[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add location action
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        tooltip: 'Add Location',
      ),
    );
  }
}
