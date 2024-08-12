import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:travio_admin/model/package_model.dart';

class TripPackageProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController totalDaysController = TextEditingController();
  TextEditingController nightsController = TextEditingController();
  TextEditingController realPriceController = TextEditingController();
  TextEditingController offerPriceController = TextEditingController();
  final TextEditingController _newActivityController = TextEditingController();

  int totalDays = 0;
  List<TextEditingController> dailyPlanningControllers = [];
  List<File> images = [];
  List<String> selectedActivities = [];
  List<String> selectedTransportOptions = [];
  bool isSubmitting = false;
  final List<String> _uploadedImagesUrls = [];

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  TextEditingController get newActivityController => _newActivityController;
  List<String> get availableActivities => _availableActivities;
  List<String> get transportOptions => _transportOptions;

  List<TripPackageModel> _package = [];
  List<TripPackageModel> get package => _package;

  String _searchQuery = '';

  List<String> _availableActivities = [
    'Hiking',
    'Swimming',
    'Sightseeing',
    'Shopping',
    'Dining',
  ];

  List<String> _transportOptions = [
    'Flight',
    'Train',
    'Bus',
    'Ship',
  ];

  void updateTotalDays(int days) {
    totalDays = days;
    dailyPlanningControllers =
        List.generate(days, (index) => TextEditingController());
    notifyListeners();
  }

  Future<void> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      images = result.paths.map((path) => File(path!)).toList();
      notifyListeners();
    }
  }

  void removeImage(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  Future<void> submitForm(BuildContext context) async {
    isSubmitting = true;
    notifyListeners();

    if (formKey.currentState?.validate() ?? false) {
      try {
        await _uploadImages();

        DocumentReference docRef =
            FirebaseFirestore.instance.collection('trip_packages').doc();
        String packageId = docRef.id;

        await docRef.set({
          'id': packageId,
          'name': nameController.text,
          'description': descriptionController.text,
          'images': _uploadedImagesUrls,
          'daily_plan': dailyPlanningControllers
              .map((controller) => controller.text)
              .toList(),
          'real_price': double.tryParse(realPriceController.text) ?? 0.0,
          'offer_price': double.tryParse(offerPriceController.text) ?? 0.0,
          'activities': selectedActivities,
          'transport_options': selectedTransportOptions,
          'number_of_days': int.tryParse(daysController.text) ?? 0,
          'number_of_nights': int.tryParse(nightsController.text) ?? 0,
          'total_number_of_days': totalDays
        });

        DocumentSnapshot packageDoc = await docRef.get();
        TripPackageModel newPackage =
            TripPackageModel.fromMap(packageDoc.data() as Map<String, dynamic>);
        _package.add(newPackage);
        _resetForm();
      } catch (e) {}
    }
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

        print('Searching for: $searchLower in ${package.name}');
        print('Activities: $activitiesLower');

        return nameLower.contains(searchLower) ||
            activitiesLower.any((activity) => activity.contains(searchLower));
      }).toList();
    }
  }

  Future<void> fetchAllPackages() async {
    try {
      QuerySnapshot tripPackageSnapshot =
          await db.collection('trip_package').get();
      _package = tripPackageSnapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (e) {
      log('Error fetching location data: $e');
    }
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> _uploadImages() async {
    for (var image in images) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = FirebaseStorage.instance
          .ref()
          .child('trip_package_images')
          .child(fileName);
      final uploadTask = ref.putFile(image);
      final snapshot = await uploadTask.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      _uploadedImagesUrls.add(url);
    }
  }

  void _resetForm() {
    nameController.clear();
    descriptionController.clear();
    totalDaysController.clear();
    daysController.clear();
    nightsController.clear();
    realPriceController.clear();
    offerPriceController.clear();
    totalDays = 0;
    dailyPlanningControllers.clear();
    images.clear();
    selectedActivities.clear();
    selectedTransportOptions.clear();
    notifyListeners();
  }
}
