import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompanyController extends GetxController {
  var isLoading = true.obs;
  var companyList = [].obs;

  @override
  void onInit() {
    fetchCompanies();
    super.onInit();
  }
// Future<void> _logout() async {
//   await _auth.signOut();
//   await _googleSignIn.signOut();

//   // Clear user credentials from SharedPreferences
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.clear();

//   // Navigate back to the Sign-In screen
//   Get.offAll(SignInScreen());
// }
  // Fetch data from API
  void fetchCompanies() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1/photos'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        companyList.value = data; // Store the fetched data in the observable list
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data');
    } finally {
      isLoading(false); // Stop loading when the API call is done
    }
  }
}
