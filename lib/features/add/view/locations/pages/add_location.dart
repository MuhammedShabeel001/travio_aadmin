import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travio_admin_/features/add/view/locations/pages/location_detail.dart';
import 'package:travio_admin_/features/add/view/locations/widgets/add_location_card.dart';
import 'package:travio_admin_/features/add/view/trip_packages/pages/package_detail.dart';

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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                // color: Colors.yellow,
                child: InkWell(
                    onTap: () {
                      log('add location tapped');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationDetails()),
                      );
                    },
                    child: AddItemCard(
                      title: 'Add Location',
                      color: Colors.blue,
                    )),
              )),
          Expanded(
              flex: 1,
              child: Container(
                // color: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: InkWell(
                  onTap: () {
                    log('add location tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PackageDetails()),
                    );
                  },
                  child: AddItemCard(title: 'Add Package',color: Colors.green,),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
              )),
        ],
      ),
    );
  }
}
