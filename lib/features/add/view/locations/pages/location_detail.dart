import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travio_admin_/features/add/view/locations/pages/add_details_page.dart';
import 'package:travio_admin_/features/add/view/locations/widgets/detail_card.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
        centerTitle: true,
        backgroundColor: Colors.purple.shade200,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPlacePage(),));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return DetailCard();
          },
        ),
      ),
    );
  }
}
