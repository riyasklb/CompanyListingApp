import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:joistictask/service/auth_service.dart';
import 'package:joistictask/views/company_list_page.dart';
import 'package:joistictask/views/sigin_screen.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  var isLoading = false.obs; 

  Future<void> checkLoginStatus() async {
    bool isLoggedIn = await _authService.isUserLoggedIn();
    if (isLoggedIn) {
      Get.off(() => CompanyListPage());
    } else {
      Get.off(() => SignInScreen());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading(true); 
      User? user = await _authService.signInWithGoogle();
      if (user != null) {
        Get.snackbar('Success', 'Signed in as ${user.displayName}');
        Get.off(() => CompanyListPage());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false); 
    }
  }
}
