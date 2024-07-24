import 'dart:developer';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travio_admin/view/pages/product/locaion2/location_detail.dart';

import '../../../widgets/product/location/add_location_card.dart';
// import 'package:travio_admin/view/pages/product/locaion2/location_detail.dart';
// import 'package:travio_admin/view/widgets/product/location/add_location_card.dart';/
// import 'package:travio_admin/features/add/view/trip_packages/pages/package_detail.dart';

class AddLocationPage extends StatelessWidget {
  const AddLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                // color: Colors.yellow,
                child: InkWell(
                    onTap: () {
                      log('add location tapped');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>const  LocationDetails()),
                      );
                    },
                    child: const AddItemCard(
                      title: 'Add Location',
                      color: Colors.blue,
                    )),
              )),
          Expanded(
              flex: 1,
              child: Container(
                // color: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: InkWell(
                  onTap: () {
                    log('add location tapped');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       // builder: (context) => const PackageDetails()
                    //       ),
                    // );
                  },
                  child: const AddItemCard(title: 'Add Package',color: Colors.green,),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                // child: ,
                // color: Colors.red,
              )),
          Expanded(
              flex: 1,
              child: Container(
                // color: Colors.green,
              )),
        ],
      ),
    );
  }
}
