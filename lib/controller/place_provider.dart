import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:travio_admin_/model/place_model.dart';

class PlaceProvider with ChangeNotifier {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedCountry;
  String? selectedContinent;

  final List<String> availableActivities = [
    'Hiking',
    'Swimming',
    'Sightseeing',
    'Shopping',
    'Dining',
  ];
  List<String> selectedActivities = [];

  List<File> _images = [];
  final List<String> _uploadedImagesUrls = [];

  List<String> countries = [
    'United States',
    'Canada',
    'Mexico',
    'India',
    'China',
    'Australia',
    // Add more countries as needed
  ];

  List<String> continents = [
    'Asia',
    'Africa',
    'North America',
    'South America',
    'Antarctica',
    'Europe',
    'Australia',
  ];

  TextEditingController get nameController => _nameController;
  TextEditingController get descriptionController => _descriptionController;
  GlobalKey<FormState> get formKey => _formKey;
  List<File> get images => _images;

  List<PlaceModel> _places = [];
  List<PlaceModel> get places => _places;

  PlaceModel? _place;
  PlaceModel? get place => _place;

  bool _submissionSuccessful = false;
  bool get submissionSuccessful => _submissionSuccessful;

  Future<void> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      _images = result.paths.map((path) => File(path!)).toList();
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
      final ref = FirebaseStorage.instance.ref().child('place_images').child(fileName);
      final uploadTask = ref.putFile(image);
      final snapshot = await uploadTask.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      _uploadedImagesUrls.add(url);
    }
  }

  Future<void> submitForm(BuildContext context) async {
    _submissionSuccessful = false;

    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        selectedCountry != null &&
        selectedContinent != null &&
        selectedActivities.isNotEmpty &&
        _images.isNotEmpty) {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children:  [
                CircularProgressIndicator(),
                SizedBox(width: 16.0),
                Text("Submitting..."),
              ],
            ),
          ),
        );

        await _uploadImages();

        DocumentReference docRef = FirebaseFirestore.instance.collection('places').doc();
        String placeId = docRef.id;

        await docRef.set({
          'id': placeId,
          'name': _nameController.text,
          'description': _descriptionController.text,
          'country': selectedCountry,
          'continent': selectedContinent,
          'activities': selectedActivities.join(', '),
          'image_urls': _uploadedImagesUrls,
        });

        // Fetch the new place and add it to the list
        DocumentSnapshot locationDoc = await docRef.get();
        PlaceModel newPlace = PlaceModel.fromMap(locationDoc.data() as Map<String, dynamic>);
        _places.add(newPlace);

        _nameController.clear();
        _descriptionController.clear();
        selectedCountry = null;
        selectedContinent = null;
        selectedActivities.clear();
        _images = [];
        _uploadedImagesUrls.clear();
        _submissionSuccessful = true;
        notifyListeners();
      } catch (e) {
        log('Error uploading data: $e');
      } finally {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    }
    notifyListeners();
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
