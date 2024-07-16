import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceModel {
  String id;
  String name;
  String description;
  String activities;
  List<String> images;

  PlaceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.activities,
    required this.images,
  });

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      activities: map['activities'] as String,
      images: List<String>.from(map['image_urls'] as List),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'activities': activities,
      'image_urls': images,
    };
  }
}
