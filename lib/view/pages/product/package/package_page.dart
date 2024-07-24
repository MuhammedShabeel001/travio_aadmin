import 'package:flutter/material.dart';

import '../../../widgets/global/search_bar.dart';

class PackagePage extends StatelessWidget {
  const PackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TSearchBar(
              hint: 'Search by package',
              controller: TextEditingController(),
              onChanged: (value) {},
            ),
            // ListView(

            //   children: [],
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add package action
        },
        backgroundColor: Colors.orange,
        tooltip: 'Add Package', // Customize the button color
        child: const Icon(Icons.add),
      ),
    );
  }
}
