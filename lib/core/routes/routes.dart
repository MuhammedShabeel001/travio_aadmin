import 'package:flutter/material.dart';
import 'package:travio_admin/view/pages/product/location/add_location_page.dart';

import '../../view/pages/dashboard/dashbord_page.dart';
// import 'package:travio_admin/view/pages/dashboard/dashbord_page.dart';


Map<String, Widget Function(BuildContext)> routes ={
  "/Dashbord": (context)=> const DashbordPage(),
  "/AddLocation": (context)=> const AddLocation(),

};