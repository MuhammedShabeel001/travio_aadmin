import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../controller/booked_provider.dart'; // Import the provider for booked users
import '../../../../model/package_model.dart';

class UsersTab extends StatelessWidget {
  final TripPackageModel tripPackage;

  const UsersTab({super.key, required this.tripPackage});

  @override
  Widget build(BuildContext context) {
    final String packageId = tripPackage.id;

    return Consumer<BookedPackageProvider>(
      builder: (context, bookedPackageProvider, _) {
        return FutureBuilder(
          future: bookedPackageProvider.fetchBookedUsers(packageId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // return const Center(child: CircularProgressIndicator()); // Show a loading spinner
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Handle errors
            }

            final bookedUsers = bookedPackageProvider.bookedUsers;

            // If there are no booked users, display an animation
            if (bookedUsers.isEmpty) {
              return SizedBox(
                height: 30,
                child: Center(
                  child: Lottie.asset(
                    'assets/animations/empty_review.json'), // No users animation
                ),
              );
            }

            // Display booked users in a ListView
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: bookedUsers.length,
              itemBuilder: (context, index) {
                final user = bookedUsers[index];
                return ListTile(
                  leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/image/default_pfpf.jpg'),
                ),
                  title: Text(user['name'] ?? 'Unknown'),
                  subtitle: Text(user['phonenumber'].toString()),
                  // Add other user details here as needed
                );
              },
            );
          },
        );
      },
    );
  }
}
