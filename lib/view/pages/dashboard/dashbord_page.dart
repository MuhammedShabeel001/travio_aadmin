import 'package:flutter/material.dart';
import 'package:travio_admin_/view/widgets/Dashbord/count_card.dart';
import 'package:travio_admin_/view/widgets/Dashbord/user_count.dart';
import 'package:travio_admin_/view/widgets/global/t_app_bar.dart';

class DashbordPage extends StatelessWidget {
  const DashbordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: tAppBar('Dashbord'),
      body:  ListView(
        children: const [ SizedBox(
          height: 220,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: CountCard(count: '1000', label: 'Locations')),Expanded(
                flex: 1,
                child: CountCard(count: '65', label: 'Packages')),
            ],
          ),
        ),
        UserCount(count: '123', label: 'Active users')
      ])
    );
  }

  
}




