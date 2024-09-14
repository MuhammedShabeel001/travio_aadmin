// import 'package:flutter/material.dart';
// import 'package:travio_admin/model/package_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:bot_toast/bot_toast.dart';

// class EditPackageProvider with ChangeNotifier {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   TripPackageModel? _currentPackage;

//   TripPackageModel? get currentPackage => _currentPackage;

//   void setCurrentPackage(TripPackageModel package) {
//     _currentPackage = package;
//     notifyListeners();
//   }

//   Future<void> updatePackageField(String field, dynamic value) async {
//     if (_currentPackage == null) return;

//     try {
//       await _db.collection('trip_packages').doc(_currentPackage!.id).update({field: value});
      
//       // Update the current package
//       Map<String, dynamic> updatedData = _currentPackage!.toMap();
//       updatedData[field] = value;
//       _currentPackage = TripPackageModel.fromMap(updatedData);
//       BotToast.showText(text: 'Package updated successfully');
      
//       notifyListeners();
//     } catch (e) {
//       print('Error updating package: $e');
//       BotToast.showText(text: 'Error updating package');
//     }
//   }

//   Future<void> showEditDialog(BuildContext context, String field) async {
//     if (_currentPackage == null) return;

//     String? newValue = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         String tempValue = _currentPackage!.getFieldValue(field).toString();
//         return AlertDialog(
//           title: Text('Edit $field'),
//           content: TextField(
//             controller: TextEditingController(text: tempValue),
//             onChanged: (value) => tempValue = value,
//             decoration: InputDecoration(labelText: 'New $field'),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             TextButton(
//               child: const Text('Save'),
//               onPressed: () => Navigator.of(context).pop(tempValue),
//             ),
//           ],
//         );
//       },
//     );

//     if (newValue != null && newValue != _currentPackage!.getFieldValue(field).toString()) {
//       await updatePackageField(field, newValue);
//     }
//   }
// }