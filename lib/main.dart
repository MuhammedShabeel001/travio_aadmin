import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/controller/package_provider.dart';
import 'package:travio_admin/controller/place_provider.dart';
import 'package:travio_admin/controller/user_provider.dart';
import 'package:travio_admin/core/common/widgets/navigation_bar.dart';
// import 'package:travio_admin/core/common/widgets/navigation_bar.dart';
import 'package:travio_admin/core/firebase/firebase_options.dart';
import 'package:travio_admin/core/routes/routes.dart';
import 'package:travio_admin/view/pages/product/package/add_package_page.dart';
// import 'package:travio_admin/view/pages/product/package/add_package_page.dart';

void main() async {
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
        ChangeNotifierProvider(
          create: (context) => PlaceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TripPackageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routes: routes,

        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: const TNavBar(),
        home: TripPackageDetailsPage(),
      ),
    );
  }
}
