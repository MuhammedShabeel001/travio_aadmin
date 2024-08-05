import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TripPackageProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController sourceLocationController = TextEditingController();
  final TextEditingController destinationLocationController = TextEditingController();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController nightsController = TextEditingController();
  final TextEditingController morningsController = TextEditingController();
  final TextEditingController realPriceController = TextEditingController();
  final TextEditingController offerPriceController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  
  String? selectedMeansOfTravel;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  List<String> selectedActivities = [];
  List<File> images = []; // Assuming you are using `dart:io` for images
  final List<String> _uploadedImagesUrls = [];
  bool isLoading = false;

  GlobalKey<FormState> get formKey => _formKey;

  // Fetch suggestions for locations
  Future<List<String>> getSuggestions(String query, String field) async {
    QuerySnapshot snapshot = await db.collection('places')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    List<String> suggestions = snapshot.docs.map((doc) {
      return (doc.data() as Map<String, dynamic>)['name'] as String;
    }).toList();

    if (field == 'initial') {
      suggestions.remove(destinationLocationController.text);
    } else if (field == 'final') {
      suggestions.remove(sourceLocationController.text);
    }

    return suggestions;
  }

  // Add trip package
  Future<void> addTripPackage(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16.0),
              Text("Submitting..."),
            ],
          ),
        ),
      );

      await _uploadImages();

      await db.collection('trip_packages').add({
        'name': nameController.text,
        'description': descriptionController.text,
        'sourceLocation': sourceLocationController.text,
        'destinationLocation': destinationLocationController.text,
        'startDate': selectedStartDate,
        'endDate': selectedEndDate,
        'days': int.parse(daysController.text),
        'nights': int.parse(nightsController.text),
        'mornings': int.parse(morningsController.text),
        'activities': selectedActivities,
        'meansOfTravel': selectedMeansOfTravel,
        'realPrice': double.parse(realPriceController.text),
        'offerPrice': double.parse(offerPriceController.text),
        'image_urls': _uploadedImagesUrls,
      });

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Trip Package added successfully')),
      );

      // Clear the form after submission
      nameController.clear();
      descriptionController.clear();
      sourceLocationController.clear();
      destinationLocationController.clear();
      daysController.clear();
      nightsController.clear();
      morningsController.clear();
      realPriceController.clear();
      offerPriceController.clear();
      selectedMeansOfTravel = null;
      selectedStartDate = null;
      selectedEndDate = null;
      selectedActivities.clear();
      images = [];
      _uploadedImagesUrls.clear();
    } catch (e) {
      log('Error adding package: $e');
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error adding trip package')),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  void toggleMeansOfTravel(String transport) {
    if (selectedMeansOfTravel == transport) {
      selectedMeansOfTravel = null;
    } else {
      selectedMeansOfTravel = transport;
    }
    notifyListeners();
  }

  void toggleActivity(String activity) {
    if (selectedActivities.contains(activity)) {
      selectedActivities.remove(activity);
    } else {
      selectedActivities.add(activity);
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
    if (index >= 0 && index < images.length) {
      images.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> _uploadImages() async {
    for (var image in images) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = FirebaseStorage.instance.ref().child('trip_package_images').child(fileName);
      final uploadTask = ref.putFile(image);
      final snapshot = await uploadTask.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      _uploadedImagesUrls.add(url);
    }
  }
}
