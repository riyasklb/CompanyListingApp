import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joistictask/controllers/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Obx(() {
      
          if (_authController.isLoading.value) {
            
            return Center(
              child: CircularProgressIndicator(),
            );
          }


          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to MyApp!',
                style: GoogleFonts.montserrat(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.h), 
              Text(
                'Sign in to continue and explore exciting features.',
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
              ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text(
                  'Sign In With Google',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.w, vertical: 12.h), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () {
                  _authController.signInWithGoogle();
                },
              ),
              SizedBox(height: 20.h),
            ],
          );
        }),
      ),
    );
  }
}
