import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travio_admin_/features/add/view/locations/widgets/add_location_card.dart';

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
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            color: Colors.yellow,
            child: AddLocationCard(),
          )),
          Expanded(
              flex: 1,
              child: Container(
            color: Colors.orange,
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
