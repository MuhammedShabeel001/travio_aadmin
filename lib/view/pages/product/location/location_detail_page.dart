import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travio_admin/controller/place_provider.dart';

import '../../../../model/place_model.dart';
import '../../../widgets/global/shimmer_loading.dart';

class LocationDetailPage extends StatelessWidget {
  final PlaceModel location;

  const LocationDetailPage({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orangeAccent[100], 
        body: Consumer<PlaceProvider>(
          builder: (context, locationProvider, child) {
            // Precache images
            for (var imageUrl in location.images) {
              precacheImage(NetworkImage(imageUrl), context);
            }

            return Container(
              decoration: const BoxDecoration(
                // color: Colors.deepOrangeAccent,
              ),
              child: Column(
                children: [
                  if (location.images.isNotEmpty)
                    Column(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
                          ),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 350.0,
                              viewportFraction: 1.0,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              onPageChanged: (index, reason) {
                                locationProvider.updateIndex(index);
                              },
                            ),
                            items: location.images.map((imageUrl) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return ClipRRect(
                                    // borderRadius: const BorderRadius.vertical(
                                        // bottom: Radius.circular(20)),
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrl,
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      placeholder: (context, url) => ShimmerPlaceholder(
                                        width: MediaQuery.of(context).size.width,
                                        height: 350.0,
                                      ),
                                      errorWidget: (context, error, stackTrace) => Image.asset(
                                        'assets/images/placeholder.png',
                                        fit: BoxFit.cover,
                                        width: MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        AnimatedSmoothIndicator(
                          activeIndex: locationProvider.currentIndex,
                          count: location.images.length,
                          effect: ScrollingDotsEffect(
                            activeDotColor: Colors.black,
                            fixedCenter: true,
                            dotColor: const Color.fromARGB(255, 255, 255, 255),
                            dotHeight: 8.0,
                            dotWidth: 8.0,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              location.name,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              location.description,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Country: ${location.country}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Continent: ${location.continent}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Activities:',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              location.activities,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
