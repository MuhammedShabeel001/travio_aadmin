import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:travio_admin/utils/consts/constants.dart';

import '../model/place_model.dart';

class PlaceProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _newActivityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController continentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedCountry;
  String? selectedContinent;
  bool _isSubmitting = false;

  List<String> selectedActivities = [];

  List<File> _images = [];
  final List<String> _uploadedImagesUrls = [];

  List<String> _availableActivities = [
    'Hiking',
    'Swimming',
    'Sightseeing',
    'Shopping',
    'Dining',
  ];

  TextEditingController get nameController => _nameController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get newActivityController => _newActivityController;
  GlobalKey<FormState> get formKey => _formKey;
  List<File> get images => _images;
  bool get isSubmitting => _isSubmitting;

  List<String> get availableActivities => _availableActivities;

  List<PlaceModel> _places = [];
  List<PlaceModel> get places => _places;

  PlaceModel? _place;
  PlaceModel? get place => _place;

    int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _submissionSuccessful = false;
  bool get submissionSuccessful => _submissionSuccessful;

  String _searchQuery = '';
  List<PlaceModel> get filteredPlaces {
    if (_searchQuery.isEmpty) {
      return _places;
    } else {
      return _places.where((place) {
        final searchLower = _searchQuery.toLowerCase();
        final activities = place.activities.toLowerCase().split(', ');

        return place.name.toLowerCase().contains(searchLower) ||
            place.country.toLowerCase().contains(searchLower) == true ||
            place.continent.toLowerCase().contains(searchLower) == true ||
            activities.any((activity) => activity.contains(searchLower));
      }).toList();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void addActivity(String activity) {
    if (!_availableActivities.contains(activity)) {
      _availableActivities.add(activity);
      notifyListeners();
    }
  }

  void addCountry(String country) {
    if (!countries.contains(country)) {
      countries.add(country);
      notifyListeners();
    }
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
    if (index >= 0 && index < _images.length) {
      _images.removeAt(index);
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

  Future<void> _uploadImages() async {
    for (var image in _images) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref =
          FirebaseStorage.instance.ref().child('place_images').child(fileName);
      final uploadTask = ref.putFile(image);
      final snapshot = await uploadTask.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      _uploadedImagesUrls.add(url);
    }
  }

  Future<void> submitForm(BuildContext context) async {
    _isSubmitting = true;
    notifyListeners();

    if (_formKey.currentState?.validate() ?? false) {
      try {
        await _uploadImages();

        DocumentReference docRef =
            FirebaseFirestore.instance.collection('places').doc();
        String placeId = docRef.id;

        await docRef.set({
          'id': placeId,
          'name': _nameController.text,
          'description': _descriptionController.text,
          'country': countryController.text,
          'continent': continentController.text,
          'activities': selectedActivities.join(', '),
          'image_urls': _uploadedImagesUrls,
        });

        DocumentSnapshot locationDoc = await docRef.get();
        PlaceModel newPlace =
            PlaceModel.fromMap(locationDoc.data() as Map<String, dynamic>);
        _places.add(newPlace);

        _nameController.clear();
        _descriptionController.clear();
        countryController.clear();
        continentController.clear();
        selectedActivities.clear();
        _images.clear();
        _uploadedImagesUrls.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Submission Successful')),
        );
      } catch (e) {
        log('Error uploading data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error submitting data')),
        );
      } finally {
        _isSubmitting = false;
        notifyListeners();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    } else {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllLocations() async {
    try {
      QuerySnapshot locationSnapshot = await db.collection('places').get();
      _places = locationSnapshot.docs
          .map((doc) => PlaceModel.fromMap(doc.data() as Map<String, dynamic>))
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

  Future<void> deleteLocation(String placeId, BuildContext context) async {
    try {
      await db.collection('places').doc(placeId).delete();
      _places.removeWhere((place) => place.id == placeId);
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location deleted successfully')),
      );
    } catch (e) {
      log('Error deleting location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error deleting location')),
      );
    }
  }
}
