import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travio_admin_/features/add/model/place_model.dart';

class DetailCard extends StatelessWidget {
  final PlaceModel place;

  const DetailCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple[100],
      child: SizedBox(
        height: 380,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: CarouselSlider(
                options: CarouselOptions(height: 200.0, autoPlay: true),
                items: place.images.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(url, fit: BoxFit.cover, width: double.infinity),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        place.name,
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        place.description,
                        maxLines: 5,
                        style: TextStyle(
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Activities: ${place.activities}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
