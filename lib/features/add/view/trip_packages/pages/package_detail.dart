// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:travio_admin_/features/add/view/locations/widgets/detail_card.dart';
// import 'package:travio_admin_/features/add/view/locations/widgets/detail_card.dart';

class PackageDetails extends StatelessWidget {
  const PackageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Packages'),
        centerTitle: true,
        backgroundColor: Colors.purple.shade200,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => AddPlacePage(),));
        },
        
        backgroundColor: Colors.purple.shade200,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            // return DetailCard(place: );
            return const Text('data');
          },
        ),
      ),
    );
  }
}
