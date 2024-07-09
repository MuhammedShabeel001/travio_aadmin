import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travio_admin_/features/add/view/locations/pages/location_detail.dart';

class AddLocationCard extends StatelessWidget {
  const AddLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log('add location tapped');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocationDetails()),
        );
      },
      child: Card(
        child: Center(
          child: Text(
            'Add Location',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
