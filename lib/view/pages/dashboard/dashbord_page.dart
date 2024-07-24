import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/controller/place_provider.dart';
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

    // Fetch users when the widget is built for the first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProvider.fetchUsers();
      placeProvider.fetchAllLocations();
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
                            count: '',
                            label: 'Locatioins',
                          );
                        } else {
                          return CountCard(
                              count: placeProvider.filteredPlaces.length
                                  .toString(),
                              label: placeProvider.filteredPlaces.length <= 1
                                  ? 'Location'
                                  : 'Locations');
                        }
                      },
                    )),
                const Expanded(
                    flex: 1, child: CountCard(count: '65', label: 'Packages')),
              ],
            ),
          ),
          Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.filteredUsers.isEmpty) {
                return const UserCount(count: '', label: 'Active usrs');
              }else{
                return UserCount(count: userProvider.filteredUsers.length.toString(), label: userProvider.filteredUsers.length <=1 ? 'Active user' : 'Active users');
              }
            },
          )
        ]));
  }
}
