import 'package:flutter/material.dart';

AppBar tAppBar(String title) {
    return AppBar(
      toolbarHeight: 30,
      backgroundColor: Colors.orangeAccent,
      title:  Text(
        title,
        style:const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
      actions: const [],
    );
  }