import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travio_admin_/test_page.dart';
import 'package:travio_admin_/view/pages/dashboard/dashbord_page.dart';
import 'package:travio_admin_/view/pages/manage/active_users.dart';
import 'package:travio_admin_/view/pages/product/locaion2/add_location.dart';

class TNavBar extends StatefulWidget {
  const TNavBar({super.key});

  @override
  State<TNavBar> createState() => _TNavBarState();
}

class _TNavBarState extends State<TNavBar> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    const DashbordPage(),
    const UsersPage(),
    const AddLocationPage(),
    const Page4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: const <Widget>[
          SvgIcon('assets/icons/dashbord.svg'),
          SvgIcon('assets/icons/manage.svg'),
          SvgIcon('assets/icons/products.svg'),
          SvgIcon('assets/icons/special.svg'),
        ],
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 255, 236, 206),
        buttonBackgroundColor: Colors.orange,
        height: 60,
        index: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

class SvgIcon extends StatelessWidget {
  final String assetName;
  const SvgIcon(this.assetName, {super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: 24,
      height: 24,
      color: Colors.black,
    );
  }
}
