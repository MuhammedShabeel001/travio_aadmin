import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookedPackageProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _bookedUsers = [];

  List<Map<String, dynamic>> get bookedUsers => _bookedUsers;

  Future<void> fetchBookedUsers(String packageId) async {
    try {
      // Fetch the booked packages for the given packageId
      final bookedPackagesSnapshot = await _firestore
          .collection('bookedPackages')
          .where('packageId', isEqualTo: packageId)
          .get();

      final userIds = bookedPackagesSnapshot.docs.map((doc) => doc['userId'] as String).toList();

      // Fetch user details for all userIds
      final usersSnapshot = await Future.wait(userIds.map((userId) =>
          _firestore.collection('users').doc(userId).get()));

      _bookedUsers = usersSnapshot.map((doc) => doc.data() as Map<String, dynamic>).toList();
      notifyListeners();
    } catch (error) {
      // Handle errors here
    }
  }
}
