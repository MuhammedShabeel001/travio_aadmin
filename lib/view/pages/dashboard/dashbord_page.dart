import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/controller/package_provider.dart';
import 'package:travio_admin/controller/place_provider.dart';
import 'package:travio_admin/view/pages/manage/active_users.dart';
import 'package:travio_admin/view/pages/product/location/location_page.dart';
import 'package:travio_admin/view/pages/product/package/package_page.dart';
import 'package:travio_admin/view/widgets/Dashbord/count_card.dart';
import 'package:travio_admin/view/widgets/global/t_app_bar.dart';

import '../../../controller/user_provider.dart';
import '../../widgets/Dashbord/user_count.dart';

class DashbordPage extends StatelessWidget {
  const DashbordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final placeProvider = Provider.of<PlaceProvider>(context);
    final packageProvider = Provider.of<TripPackageProvider>(context);

    // Fetch users when the widget is built for the first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProvider.fetchUsers();
      placeProvider.fetchAllLocations();
      packageProvider.fetchAllPackages();
    });

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: tAppBar('Dashbord'),
        body: ListView(children: [
          SizedBox(
            height: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 1,
                    child: Consumer<PlaceProvider>(
                      builder: (context, placeProvider, child) {
                        if (placeProvider.filteredPlaces.isEmpty) {
                          return const CountCard(
                            count: '0',
                            label: 'Locatioins',
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LocationPage(),
                                  ));
                            },
                            child: CountCard(
                                count: placeProvider.filteredPlaces.length
                                    .toString(),
                                label: placeProvider.filteredPlaces.length <= 1
                                    ? 'Location'
                                    : 'Locations'),
                          );
                        }
                      },
                    )),
                 Expanded(
                    flex: 1,
                    child: Consumer<TripPackageProvider>(
                      builder: (context, packageProvider, child) {
                        if (packageProvider.filteredPackages.isEmpty) {
                          return const CountCard(
                            count: '0', 
                            label: 'Packages',
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PackagePage(),
                                  ));
                            },
                            child: CountCard(
                                count: packageProvider.filteredPackages.length
                                    .toString(),
                                label: packageProvider.filteredPackages.length <= 1
                                    ? 'Package'
                                    : 'packages'),
                          );
                        }
                      },
                    )),
              ],
            ),
          ),
          Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.filteredUsers.isEmpty) {
                return const UserCount(count: '0', label: 'Active usrs');
              } else {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UsersPage(),
                        ));
                  },
                  child: UserCount(
                      count: userProvider.filteredUsers.length.toString(),
                      label: userProvider.filteredUsers.length <= 1
                          ? 'Active user'
                          : 'Active users'),
                );
              }
            },
          )
        ]),
        floatingActionButton: FloatingActionButton.small(onPressed: (){
// BotToast.showCustomNotification(toastBuilder: toastBuilder);

        }),
        );
  }
}
