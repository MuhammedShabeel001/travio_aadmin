import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travio_admin_/controller/user_provider.dart';
import 'package:travio_admin_/view/widgets/global/search_bar.dart';
import 'package:travio_admin_/view/widgets/global/t_app_bar.dart';
import 'package:travio_admin_/view/widgets/manage/user_tile.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Fetch users when the widget is built for the first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProvider.fetchUsers();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: tAppBar('Users'),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TSearchBar(
              hint: 'Search by name or email',
              controller: userProvider.searchController,
              onChanged: (value) {
                userProvider.updateSearchQuery(value);
              },
            ),
          ),
          // User list
          Expanded(
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                if (userProvider.filteredUsers.isEmpty) {
                  return ListView.builder(
                    itemCount: 5, // Number of shimmer placeholders
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: userProvider.filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = userProvider.filteredUsers[index];
                      return UserTile(
                        image: user['image'] ?? 'assets/image/default_user.png',
                        name: user['name'] ?? 'Unknown',
                        email: user['email'] ?? 'No email',
                        reviews: user['reviews'] ?? 'No reviews',
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
