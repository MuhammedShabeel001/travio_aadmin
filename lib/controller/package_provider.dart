import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:travio_admin/model/package_model.dart';
import '../utils/consts/constants.dart';

class TripPackageProvider with ChangeNotifier {

  // final FirebaseFirestore _db = FirebaseFirestore.instance;
  TripPackageModel? _currentPackage;

  TripPackageModel? get currentPackage => _currentPackage;

  void setCurrentPackage(TripPackageModel package) {
    _currentPackage = package;
    notifyListeners();
  }

Future<void> updatePackageField(String field, dynamic value) async {
    if (_currentPackage == null) return;

    try {
      await db.collection('trip_packages').doc(_currentPackage!.id).update({field: value});
      
      // Update the current package
      Map<String, dynamic> updatedData = _currentPackage!.toMap();
      updatedData[field] = value;
      _currentPackage = TripPackageModel.fromMap(updatedData);
      
      // Notify listeners immediately after updating the current package
      notifyListeners();
      
      BotToast.showText(text: 'Package updated successfully');
    } catch (e) {
      print('Error updating package: $e');
      BotToast.showText(text: 'Error updating package');
    }
  }

  Future<void> showEditDialog(BuildContext context, String field) async {
    if (_currentPackage == null) return;

    String? newValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String tempValue = _currentPackage!.getFieldValue(field).toString();
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: TextEditingController(text: tempValue),
            onChanged: (value) => tempValue = value,
            decoration: InputDecoration(labelText: 'New $field'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () => Navigator.of(context).pop(tempValue),
            ),
          ],
        );
      },
    );

    if (newValue != null && newValue != _currentPackage!.getFieldValue(field).toString()) {
      await updatePackageField(field, newValue);
    }
  }
  
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController totalDaysController = TextEditingController();
  TextEditingController nightsController = TextEditingController();
  TextEditingController realPriceController = TextEditingController();
  TextEditingController offerPriceController = TextEditingController();
  final TextEditingController _newActivityController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  int totalDays = 0;
  List<TextEditingController> dailyPlanningControllers = [];
  final List<File> _images = [];

  List<String> selectedActivities = [];
  List<String> selectedTransportOptions = [];
  bool _isSubmitting = false;
  final List<String> _uploadedImagesUrls = [];
  List<String> selectedCountries = [];

  List<String> availableCountries = countries;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  TextEditingController get newActivityController => _newActivityController;
  List<String> get availableActivities => _availableActivities;
  List<String> get transportOptions => _transportOptions;
  GlobalKey<FormState> get formKey => _formKey;
  bool get isSubmitting => _isSubmitting;
  List<File> get images => _images;

  List<TripPackageModel> _package = [];
  List<TripPackageModel> get package => _package;

  String _searchQuery = '';

  final List<String> _availableActivities = [
    'Hiking', 'Camping', 'Beach', 'Cycling', 'Sightseeing',
    'Adventure Sports', 'Wildlife Safari', 'Skiing',
    'Cultural Experience', 'Culinary Tours', 'Water Sports',
    'Wellness and Spa', 'Photograph', 'Road Trips', 'Cruise',
    'Historical Tours', 'Luxury Travel', 'Festival and Events',
    'Eco-Tourism', 'Family-Friendly', 'Volunteer Travel',
    'Shopping', 'Religious and Spiritual Tour', 'Nightlife and Entertainment'
  ];

  final List<String> _transportOptions = [
    'Flight', 'Train', 'Bus', 'Ship', 'Yacht', 'Car', 'Taxi',
    'Bicycle', 'Motorbike', 'Scooter', 'Walking', 'Tram',
    'Metro', 'Ferry', 'Helicopter', 'Campervan', 'RV',
    'Rickshaw', 'Tuk-Tuk', 'Horseback', 'Cable Car', 'Snowmobile',
  ];

  void addCountry(String country) {
    if (!countries.contains(country)) {
      countries.add(country);
      notifyListeners();
    }
  }

  void updateTotalDays(int days) {
    totalDays = days;
    dailyPlanningControllers =
        List.generate(days, (index) => TextEditingController());
    notifyListeners();
  }

  void toggleCountrySelection(String country) {
    if (selectedCountries.contains(country)) {
      selectedCountries.remove(country);
    } else {
      selectedCountries.add(country);
    }
    notifyListeners();
  }

  Future<void> pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result != null) {
      images.addAll(result.files.map((file) => File(file.path!)).toList());
      notifyListeners();
    }
  }

  void removeImage(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  void addActivity(String activity) {
    if (!_availableActivities.contains(activity)) {
      _availableActivities.add(activity);
      notifyListeners();
    }
  }

  void toggleActivity(String activity) {
    if (selectedActivities.contains(activity)) {
      selectedActivities.remove(activity);
    } else {
      selectedActivities.add(activity);
    }
    notifyListeners();
  }

  void toggleTransport(String transport) {
    if (selectedTransportOptions.contains(transport)) {
      selectedTransportOptions.remove(transport);
    } else {
      selectedTransportOptions.add(transport);
    }
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<TripPackageModel> get filteredPackages {
    if (_searchQuery.isEmpty) {
      return _package;
    } else {
      final searchLower = _searchQuery.toLowerCase();
      return _package.where((package) {
        final nameLower = package.name.toLowerCase();
        final activitiesLower = package.activities
            .map((activity) => activity.toLowerCase())
            .toList();

        return nameLower.contains(searchLower) ||
            activitiesLower.any((activity) => activity.contains(searchLower));
      }).toList();
    }
  }

  Future<void> fetchAllPackages() async {
    try {
      QuerySnapshot tripPackageSnapshot =
          await db.collection('trip_packages').get();

      _package = tripPackageSnapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      notifyListeners();
    } catch (e) {
      log('Error fetching package data: $e');
      BotToast.showText(text: 'Error fetching package data');
    }
  }

  Future<void> fetchLastAddedPackages() async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection('trip_packages')
          .orderBy('created_at', descending: true) // Assuming you have a 'created_at' field
          .limit(3)
          .get();

      _package = querySnapshot.docs
          .map((doc) => TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      notifyListeners();
    } catch (e) {
      log('Error fetching last added packages: $e');
      BotToast.showText(text: 'Error fetching last added packages');
    }
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> _uploadImages() async {
    for (var image in _images) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = FirebaseStorage.instance
          .ref()
          .child('package_images')
          .child(fileName);
      final uploadTask = ref.putFile(image);
      final snapshot = await uploadTask.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      _uploadedImagesUrls.add(url);
    }
  }

  Future<void> submitForm(BuildContext context) async {
    _isSubmitting = true;
    notifyListeners();

    if (formKey.currentState?.validate() ?? false) {
      try {
        _uploadedImagesUrls.clear();
        
        await _uploadImages();

        DocumentReference docRef =
            FirebaseFirestore.instance.collection('trip_packages').doc();
        String packageId = docRef.id;

        Map<int, String> dailyPlanMap = {};
        for (int i = 0; i < dailyPlanningControllers.length; i++) {
          dailyPlanMap[i] = dailyPlanningControllers[i].text;
        }

        await docRef.set({
          'id': packageId,
          'name': nameController.text,
          'description': descriptionController.text,
          'images': _uploadedImagesUrls,
          'daily_plan': dailyPlanMap.map((key, value) => MapEntry(key.toString(), value)),
          'real_price': double.tryParse(realPriceController.text),
          'offer_price': double.tryParse(offerPriceController.text),
          'activities': selectedActivities,
          'locations': selectedCountries,
          'transport_options': selectedTransportOptions,
          'number_of_days': int.tryParse(daysController.text),
          'number_of_nights': int.tryParse(nightsController.text),
          'total_number_of_days': totalDays,
          'booked_count': 0,
          'like_count': 0,
          'rating_count': 0.0,
          'customer_reviews': {},
          'liked_by_user_ids': [],
        });

        DocumentSnapshot packageDoc = await docRef.get();
        TripPackageModel newPackage =
            TripPackageModel.fromMap(packageDoc.data() as Map<String, dynamic>);
        _package.add(newPackage);
        BotToast.showText(text: 'Package added successfully');

        _resetForm();
        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        log('Error uploading data: $e');
        BotToast.showText(text: 'Error submitting data');
      } finally {
        _isSubmitting = false;
        notifyListeners();
      }
    } else {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  Future<void> deletePackage(String packageId) async {
    try {
      await db.collection('trip_packages').doc(packageId).delete();
      _package.removeWhere((package) => package.id == packageId);
      notifyListeners();
      BotToast.showText(text: 'Package Deleted');
    } catch (e) {
      log('Error deleting location: $e');
      BotToast.showText(text: 'Error deleting location');
    }
  }

  void _resetForm() {
    nameController.clear();
    countryController.clear();
    selectedCountries.clear();
    descriptionController.clear();
    totalDaysController.clear();
    daysController.clear();
    nightsController.clear();
    realPriceController.clear();
    offerPriceController.clear();
    totalDays = 0;
    dailyPlanningControllers.clear();
    _images.clear();
    _uploadedImagesUrls.clear();
    selectedActivities.clear();
    selectedTransportOptions.clear();
    notifyListeners();
  }
}