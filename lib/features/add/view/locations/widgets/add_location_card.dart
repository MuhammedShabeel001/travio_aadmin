import 'package:flutter/material.dart';

class AddItemCard extends StatelessWidget {
  final String title;
  final Color color;
  const AddItemCard({
    super.key,
    required this.title, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
