import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/view/pages/product/locaion2/add_details_page.dart';


import '../../../../controller/place_provider.dart';
import '../../../widgets/product/location/detail_card.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context, listen: false);

    // Fetch locations when the widget is built for the first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      placeProvider.fetchAllLocations();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        centerTitle: true,
        backgroundColor: Colors.purple.shade200,  
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDetailsPage()),
          );
        },
        backgroundColor: Colors.purple.shade200,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Consumer<PlaceProvider>(
          builder: (context, placeProvider, child) {
            if (placeProvider.places.isEmpty) {
              return const Center(child: CircularProgressIndicator());
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
    );
  }
}
