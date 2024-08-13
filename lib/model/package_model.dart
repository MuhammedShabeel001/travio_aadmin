// ignore_for_file: public_member_api_docs, sort_constructors_first

class TripPackageModel {
  String id;
  String name;
  String description;
  List<String> images;
  Map<int, String> dailyPlan; // Plan for each day
  double realPrice;
  double offerPrice;
  List<String> activities;
  List<String> transportOptions;
  int numberOfDays;
  int numberOfNights;
  int totalDays;
  List<String>? customerReviews; // Nullable customer reviews
  int bookedCount;
  int likeCount;

  TripPackageModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.dailyPlan,
    required this.realPrice,
    required this.offerPrice,
    required this.activities,
    required this.transportOptions,
    required this.numberOfDays,
    required this.numberOfNights,
    required this.totalDays,
    this.customerReviews,
    this.bookedCount = 0,
    this.likeCount = 0,
  });

  factory TripPackageModel.fromMap(Map<String, dynamic> map) {
    // Safely handle the dailyPlan field which might be a List or a Map
    final dailyPlanData = map['daily_plan'];

    // Check if dailyPlanData is a Map or List and handle accordingly
    Map<int, String> dailyPlan = {};
    if (dailyPlanData is Map<String, dynamic>) {
  dailyPlan = dailyPlanData.map(
    (key, value) => MapEntry(int.tryParse(key) ?? 0, value as String),
  );
} else if (dailyPlanData is List<dynamic>) {
      // Handle if it's a List; convert list items to Map<int, String> if possible
      for (int i = 0; i < dailyPlanData.length; i++) {
        dailyPlan[i] = dailyPlanData[i] as String;
      }
    }

    return TripPackageModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      images: List<String>.from(map['images'] as List<dynamic>),
      dailyPlan: dailyPlan,
      realPrice: (map['real_price'] as num).toDouble(),
      offerPrice: (map['offer_price'] as num).toDouble(),
      activities: List<String>.from(map['activities'] as List<dynamic>),
      transportOptions: List<String>.from(map['transport_options'] as List<dynamic>),
      numberOfDays: map['number_of_days'] as int,
      numberOfNights: map['number_of_nights'] as int,
      customerReviews: map['customer_reviews'] != null
          ? List<String>.from(map['customer_reviews'] as List<dynamic>)
          : null,
      bookedCount: map['booked_count'] as int? ?? 0,
      likeCount: map['like_count'] as int? ?? 0,
      totalDays: map['total_number_of_days'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'daily_plan': dailyPlan,
      'real_price': realPrice,
      'offer_price': offerPrice,
      'activities': activities,
      'transport_options': transportOptions,
      'number_of_days': numberOfDays,
      'number_of_nights': numberOfNights,
      'customer_reviews': customerReviews,
      'booked_count': bookedCount,
      'like_count': likeCount,
      'total_number_of_days': totalDays
    };
  }
}
