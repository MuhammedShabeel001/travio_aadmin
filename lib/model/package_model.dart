// ignore_for_file: public_member_api_docs, sort_constructors_first


class PackageModel {
  String id;
  String name;
  String description;
  String locationId1;
  String locationId2;
  DateTime? startDate;
  DateTime? endDate;
  int days;
  String nights;
  String morning;
  List<String> images;
  String country;
  String continent;
  String activities;
  String transportOptions;
  double price;
  double offerPrice;

  PackageModel({
    required this.id,
    required this.name,
    required this.description,
    required this.locationId1,
    required this.locationId2,
    this.startDate,
    this.endDate,
    required this.days,
    required this.nights,
    required this.morning,
    required this.images,
    required this.country,
    required this.continent,
    required this.activities,
    required this.transportOptions,
    required this.price,
    required this.offerPrice,
  });

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      locationId1: map['loaction_id_1'] as String,
      locationId2: map['location_id_2'] as String,
      days: map['days'] as int,
      nights: map['nights'] as String,
      morning: map['mornings'] as String,
      images: List<String>.from(map['images'] as List),
      country: map['country'] as String,
      continent: map['continent'] as String,
      activities: map['activities'] as String,
      transportOptions: map['transport_options'] as String,
      price: map['price'] as double,
      offerPrice: map['offer_price'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location_id_1': locationId1,
      'location_id_2': locationId2,
      'days': days,
      'nights': nights,
      'mornings': morning,
      'images': images,
      'transport_options': transportOptions,
      'country': country,
      'continent': continent,
      'activities': activities,
      'price': price,
      'offer_price': offerPrice
    };
  }
}
