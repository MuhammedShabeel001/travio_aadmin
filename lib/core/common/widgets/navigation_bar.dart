import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:travio_admin_/test_page.dart';
import 'package:travio_admin_/features/add/view/locations/pages/add_location.dart';

class TNavBar extends StatefulWidget {
  const TNavBar({super.key});

  @override
  State<TNavBar> createState() => _TNavBarState();
}

class _TNavBarState extends State<TNavBar> {
  int currentIndex = 0;
  

  final List<Widget> _pages = [
    const Page1(),
    const Page2(),
    const AddLocationPage(),
    const Page4(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       
        body: _pages[currentIndex],
        bottomNavigationBar: BottomBarFloating(
          items: const [
            TabItem(icon: Icons.analytics, title: 'Analytics'),
            TabItem(icon: Icons.list, title: 'Users List'),
            TabItem(icon: Icons.add, title: 'Add'),
            TabItem(icon: Icons.warning, title: 'Warnings'),
          ],
          backgroundColor: Colors.white,
          color: Colors.grey,
          colorSelected: Colors.blue,
          indexSelected: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}