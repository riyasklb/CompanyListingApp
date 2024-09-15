import 'package:get/get.dart';
import 'package:joistictask/service/job_service.dart';

import 'package:joistictask/models/get_job_model.dart';

class CompanyController extends GetxController {
  var isLoading = true;
  var companyList = <GetJobModel>[];

  final JobsApiService jobsApiService = JobsApiService();

  @override
  void onInit() {
    fetchCompanies();
    super.onInit();
  }

  void fetchCompanies() async {
    try {
      isLoading = true;
      update();

   
      companyList = await jobsApiService.fetchCompanies();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void applyForJob(int id) {
    var index = companyList.indexWhere((company) => company.id == id);
    if (index != -1) {
      companyList[index].applied = true;
      update();
    }
  }
}
