import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({this.milliseconds = 300});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class UserProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  final Debouncer _debouncer = Debouncer();

  final List<Map<String, String>> _users = [
    {
      'image': 'assets/image/ios-18-neuerungen-teaser-neu_6295364.jpg',
      'name': 'John Doe',
      'email': 'john@example.com',
      'reviews': '10 reviews'
    },
    {
      'image': 'assets/image/ios-18-neuerungen-teaser-neu_6295364.jpg',
      'name': 'Jane Doe',
      'email': 'jane@example.com',
      'reviews': '5 reviews'
    },
    // Add more users here...
  ];

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

  void updateSearchQuery(String query) {
    _debouncer.run(() {
      searchQuery = query;
      notifyListeners();
    });
  }
}
