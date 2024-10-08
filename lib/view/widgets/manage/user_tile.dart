import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Assuming you're using flutter_svg package for SvgIcon

class UserTile extends StatelessWidget {
  final String image;
  final String name;
  final String email;
  final String? reviews; // Allowing null value

  const UserTile({
    super.key,
    required this.image,
    required this.name,
    required this.email,
    this.reviews, // Optional parameter
  });

  @override
  Widget build(BuildContext context) {
    // Determine the image to display based on the pronouns
    String imagePath = 'assets/image/default_user.png'; // Default image
    if (image == 'he/him') {
      imagePath = 'assets/image/boy.png'; // Path for boy image
    } else if (image == 'she/her') {
      imagePath = 'assets/image/girl.png'; // Path for girl image
    } else if (image == 'they/them') {
      imagePath = 'assets/image/they_them.png'; // Path for non-binary image
    }

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.orange.shade100,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 60,
              width: 60,
              child: Image.asset(
                imagePath, // Use imagePath here
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                email,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                reviews ?? 'No reviews',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          trailing: PopupMenuButton<String>(
            icon: SvgPicture.asset('assets/icons/more.svg'),
            onSelected: (value) {
              if (value == 'block') {
                // Handle block user action
                log('Block user $name');
              } else if (value == 'delete') {
                // Handle delete user action
                log('Delete user $name');
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'block',
                  child: Row(
                    children: [
                      Icon(Icons.block, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Block User', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete User', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ];
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.white,
            elevation: 4,
            offset: const Offset(0, 40),
          ),
        ),
      ),
    );
  }
}
