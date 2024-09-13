import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:joistictask/app/src/screens/company_list_page.dart';
import 'package:joistictask/app/src/screens/sigin_screen.dart';
import 'package:joistictask/app/src/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job Portal App',
      initialRoute: '/companylistpage',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/signin', page: () => SignInScreen()),
        GetPage(name: '/companylistpage', page: () => CompanyListPage()),
      ],
    );
  }
}
