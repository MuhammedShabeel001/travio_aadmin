import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin_/controller/user_provider.dart';
import 'package:travio_admin_/view/widgets/global/search_bar.dart';
import 'package:travio_admin_/view/widgets/global/t_app_bar.dart';
import 'package:travio_admin_/view/widgets/manage/user_tile.dart';
// import 'search_bar.dart';
// import 'user_tile.dart';
// import 't_app_bar.dart';
// import 'user_provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: tAppBar('Users'),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return Column(
            children: [
              // Search bar
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TSearchBar(
                      controller: userProvider.searchController,
                      onChanged:(value) {
                       userProvider.updateSearchQuery(value);
                    },)

                  // SearchBar(
                  //   controller: userProvider.searchController,
                  //   onChanged: (value) {
                  //     userProvider.updateSearchQuery(value);
                  //   },
                  // ),
                  ),
              // User list
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: userProvider.filteredUsers.map((user) {
                    return UserTile(
                      image: user['image']!,
                      name: user['name']!,
                      email: user['email']!,
                      reviews: user['reviews']!,
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
