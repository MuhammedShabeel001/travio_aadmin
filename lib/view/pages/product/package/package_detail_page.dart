import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/model/package_model.dart';
import 'package:travio_admin/controller/package_provider.dart';

import '../../../widgets/product/package/bottom_buttom.dart';
import '../../../widgets/product/package/carousal_images.dart';
import '../../../widgets/product/package/likes_review.dart';
import '../../../widgets/product/package/package_info.dart';
import '../../../widgets/product/package/review_details.dart';


class TripPackageDetailPage extends StatelessWidget {
  final TripPackageModel tripPackage;

  const TripPackageDetailPage({Key? key, required this.tripPackage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<TripPackageProvider>(
          builder: (context, packageProvider, child) {
            // Precache images
            for (var imageUrl in tripPackage.images) {
              precacheImage(NetworkImage(imageUrl), context);
            }

            return DefaultTabController(
              length: 2,
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
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(100.0),
                        child: Column(
                          children: const [
                            TabBar(
                              indicatorColor: Colors.white,
                              labelColor: Colors.white,
                              tabs: [
                                Tab(text: "About"),
                                Tab(text: "Reviews"),
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
                    const ReviewsTab(),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: const BookButton(),
      ),
    );
  }
}
