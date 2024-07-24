import 'package:flutter/material.dart';

import '../../view/pages/dashboard/dashbord_page.dart';
// import 'package:travio_admin/view/pages/dashboard/dashbord_page.dart';


Map<String, Widget Function(BuildContext)> routes ={
  "/Dashbord": (context)=> const DashbordPage(),

};