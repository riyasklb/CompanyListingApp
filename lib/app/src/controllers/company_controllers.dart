import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:joistictask/app/src/model/get_job_model.dart';


class CompanyController extends GetxController {
  var isLoading = true;
  var companyList = <GetJobModel>[];

  @override
  void onInit() {
    fetchCompanies();
    super.onInit();
  }

  // Fetch data from API and store it in memory
  void fetchCompanies() async {
    try {
      isLoading = true;
      update(); // Notify GetBuilder that the loading state has changed

      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1/photos'));

      if (response.statusCode == 200) {
        var data = getJobModelFromJson(response.body);
        companyList = data;
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e');
    } finally {
      isLoading = false;
      update(); // Notify GetBuilder that the loading state has changed
    }
  }

  // Update applied status in memory only
  void applyForJob(int id) {
    var index = companyList.indexWhere((company) => company.id == id);
    if (index != -1) {
      companyList[index].applied = true;
      update(); // Notify GetBuilder that the list has changed
    }
  }
}
