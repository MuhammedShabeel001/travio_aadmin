import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/model/package_model.dart';
import 'package:travio_admin/controller/package_provider.dart';
import 'package:travio_admin/view/pages/product/package/add_package_page.dart';
import 'package:travio_admin/view/widgets/product/package/booked_user_list.dart';

import '../../../widgets/product/package/bottom_buttom.dart';
import '../../../widgets/product/package/carousal_images.dart';
import '../../../widgets/product/package/likes_review.dart';
import '../../../widgets/product/package/package_info.dart';
import '../../../widgets/product/package/review_details.dart';

class TripPackageDetailPage extends StatelessWidget {
  final TripPackageModel tripPackage;

  const TripPackageDetailPage({super.key, required this.tripPackage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TripPackageProvider>(
        builder: (context, packageProvider, child) {
          // Precache images
          for (var imageUrl in tripPackage.images) {
            precacheImage(NetworkImage(imageUrl), context);
          }

          return DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 350.0,
                    pinned: true,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: CarouselWidget(tripPackage: tripPackage),
                    ),
                    bottom: const PreferredSize(
                      preferredSize: Size.fromHeight(100.0),
                      child: Column(
                        children: [
                          TabBar(
                            indicatorColor: Colors.black,
                            labelColor: Colors.black,
                            tabs: [
                              Tab(text: "About"),
                              Tab(text: "Reviews"),
                              Tab(text: "Users"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PackageInfoWidget(tripPackage: tripPackage),
                        const SizedBox(height: 24),
                        LikesAndReviewsWidget(tripPackage: tripPackage),
                      ],
                    ),
                  ),
                  ReviewsTab(tripPackage: tripPackage),
                  UsersTab(tripPackage: tripPackage),
                  // const ReviewsTab(),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:
          BookButton(tripPackage: tripPackage, tripPackageId: tripPackage.id),
    );
  }
}
