// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../controller/package_provider.dart';

class CustomTextForm extends StatelessWidget {
  CustomTextForm({
    Key? key,
    required this.tripPackageProvider,
    required this.controller,
    required this.label,
     this.validator,
    this.inputType,
    this.onChanged, // Optional onChanged
    this.minLines,  // Optional minLines
    this.maxLines,  // Optional maxLines
  }) : super(key: key);

  final TripPackageProvider tripPackageProvider;
  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged; // Changed to nullable
  final TextInputType? inputType;
  final int? minLines; // Changed to nullable
  final int? maxLines; // Changed to nullable

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.orange[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(color: Colors.orange[700]),
      ),
      validator: validator,
      keyboardType: inputType,
      onChanged: onChanged, // Use onChanged if provided
      minLines: minLines ?? 1, // Use minLines if provided, otherwise default to 1
      maxLines: maxLines, // Use maxLines if provided
    );
  }
}
