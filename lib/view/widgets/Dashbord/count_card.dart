import 'package:flutter/material.dart';

class CountCard extends StatelessWidget {
  final String count;
  final String label;
  const CountCard({
    super.key, required this.count, required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child:  SizedBox(
        height: double.infinity,
        child: Card(
          color: Colors.white,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  count,
                  style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 28),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
