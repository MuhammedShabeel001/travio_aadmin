import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PlaceProvider with ChangeNotifier {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _activitiesController = TextEditingController();
  List<File> _images = [];
  final List<String> _uploadedImagesUrls = [];

  TextEditingController get nameController => _nameController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get activitiesController => _activitiesController;
  List<File> get images => _images;

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

  Future<void> submitForm() async {
    if (_nameController.text.isNotEmpty && _descriptionController.text.isNotEmpty && _activitiesController.text.isNotEmpty && _images.isNotEmpty) {
      await _uploadImages();

      DocumentReference docRef = FirebaseFirestore.instance.collection('places').doc();
      String placeId = docRef.id;

      await docRef.set({
        'id': placeId,
        'name': _nameController.text,
        'description': _descriptionController.text,
        'activities': _activitiesController.text,
        'image_urls': _uploadedImagesUrls,
      });

      _nameController.clear();
      _descriptionController.clear();
      _activitiesController.clear();
      _images = [];
      _uploadedImagesUrls.clear();
      notifyListeners();
    }
  }
}
