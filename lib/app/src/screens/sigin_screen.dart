import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'company_list_page.dart';

class SignInScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _storeUserCredentials(User? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user != null) {
      await prefs.setString('userEmail', user.email ?? '');
      await prefs.setString('userId', user.uid);
    }
  }

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase sign-in
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Store user credentials in SharedPreferences
      await _storeUserCredentials(user);

      return user;
    } catch (error) {
      Get.snackbar('Error', 'Google Sign-In failed: $error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.login, color: Colors.white),
          label: Text('Sign In With Google'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          ),
          onPressed: () async {
            final User? user = await _signInWithGoogle();
            if (user != null) {
              Get.snackbar('Success', 'Signed in as ${user.displayName}');
              // Navigate to company listing page after successful login
              Get.off(CompanyListPage());
            }
          },
        ),
      ),
    );
  }
}
