import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'company_list_page.dart';
import 'sigin_screen.dart'; // Your sign-in screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();

    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userEmail = prefs.getString('userEmail');

      if (userEmail != null && userEmail.isNotEmpty) {
        Get.off(CompanyListPage());
      } else {
        Get.off(SignInScreen());
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App logo or icon
                  Icon(
                    Icons.business_center,
                    size: 80.w, // Responsive width using ScreenUtil
                    color: Colors.white,
                  ),
                  SizedBox(height: 20.h), // Responsive height using ScreenUtil
                  // App title
                  Text(
                    'Job Portal',
                    style: TextStyle(
                      fontSize: 36.sp, // Responsive text size using ScreenUtil
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Loading indicator
                  CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3.w, // Responsive stroke width using ScreenUtil
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
