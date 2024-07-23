import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin_/controller/user_provider.dart';
// import 'package:travio_admin_/core/common/pages/navbar.dart';
// ignore: unused_import
import 'package:travio_admin_/core/common/widgets/navigation_bar.dart';
import 'package:travio_admin_/controller/place_provider.dart';
import 'package:travio_admin_/core/firebase/firebase_options.dart';
// import 'package:travio_admin_/view/pages/dashboard/dashbord_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlaceProvider(),),
        ChangeNotifierProvider(create: (context) => UserProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: TNavBar(),
      ),
    );
  }
}

