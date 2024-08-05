class PlaceModel {
  final String id;
  final String name;
  final String description;
  final String country;
  final String continent;
  final String activities;
  final List<String> images;

  PlaceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.country,
    required this.continent,
    required this.activities,
    required this.images,
  });

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      country: map['country'] as String,
      continent: map['continent'] as String,
      activities: map['activities'] as String,
      images: List<String>.from(map['image_urls'] as List),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'country': country,
      'continent': continent,
      'activities': activities,
      'image_urls': images,
    };
  }
}
