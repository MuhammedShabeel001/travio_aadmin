import 'package:flutter/material.dart';

class UserCount extends StatelessWidget {
  final String count;
  final String label;
  const UserCount({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10 ),
        child: Card( 
          color: const Color.fromARGB(255, 211, 238, 212),
          elevation: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                count,
                style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
