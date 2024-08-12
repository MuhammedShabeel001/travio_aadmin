import 'package:flutter/material.dart';
import 'package:travio_admin/view/pages/product/location/location_page.dart';
import 'package:travio_admin/view/pages/product/package/package_page.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.orangeAccent,
          appBar: 
          
          AppBar(
            backgroundColor: Colors.orangeAccent,

            title: const Text(
              'Product',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            bottom: const 
          TabBar(
                indicatorWeight: 13,
                indicatorSize: TabBarIndicatorSize.tab,
                physics: BouncingScrollPhysics(),
                labelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 18),
                indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                tabs: [
                  Tab(
                    text: 'Locations',
                  ),
                  Tab(
                    text: 'Packages',
                  ),
                ]),
          ),
          body: const TabBarView(children: [
            LocationPage(),
            PackagePage(),
          ]),
        ),
      ),
    );
  }
}
