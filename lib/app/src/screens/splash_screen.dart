import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to the SignIn screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed('/signin'); // Remove splash screen from the stack
    });

    return Scaffold(
      body: Center(
        child: Text(
          'Job Portal',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
