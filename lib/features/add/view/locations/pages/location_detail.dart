import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin_/features/add/controller/place_provider.dart';
import 'package:travio_admin_/features/add/view/locations/pages/add_details_page.dart';
import 'package:travio_admin_/features/add/view/locations/widgets/detail_card.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context, listen: false);

    // Fetch locations when the widget is built for the first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      placeProvider.fetchAllLocations();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
        centerTitle: true,
        backgroundColor: Colors.purple.shade200,  
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDetailsPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Consumer<PlaceProvider>(
          builder: (context, placeProvider, child) {
            if (placeProvider.places.isEmpty) {
              return Center(child: CircularProgressIndicator());
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
