import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistictask/app/src/screens/sigin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'company_list_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check user login status after a short delay
    Future.delayed(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userEmail = prefs.getString('userEmail');

      if (userEmail != null && userEmail.isNotEmpty) {
        // If user is logged in, navigate to the company list page
        Get.off(CompanyListPage());
      } else {
        // If no user is logged in, navigate to the sign-in page
        Get.off(SignInScreen());
      }
    });

    return Scaffold(
      body: Center(
        child: Text(
          'Job Portal',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
