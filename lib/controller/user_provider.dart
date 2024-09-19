import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({this.milliseconds = 300});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class UserProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  final Debouncer _debouncer = Debouncer();
  List<Map<String, String>> _users = [];
  bool _dataFetched = false; // Flag to check if data has been fetched

  UserProvider() {
    fetchUsers();
  }

  List<Map<String, String>> get users => _users;

  List<Map<String, String>> get filteredUsers {
    if (searchQuery.isEmpty) {
      return _users;
    } else {
      return _users
          .where((user) =>
              user['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
              user['email']!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  Future<void> fetchUsers() async {
    if (_dataFetched) return; // Avoid refetching data
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      _users = snapshot.docs.map((doc) {
        return {
          'image': doc['pronouns'] ?? '', // Use pronouns field
          'name': doc['name'] ?? '',
          'email': doc['email'] ?? '',
        }.map((key, value) =>
            MapEntry(key, value.toString())); // Casting to String
      }).toList();
      log('$snapshot');
      _dataFetched = true; // Data has been fetched
      notifyListeners();
    } catch (e) {
      log('Error fetching users: $e');
    }
  }

  void updateSearchQuery(String query) {
    _debouncer.run(() {
      searchQuery = query;
      notifyListeners();
    });
  }
}
