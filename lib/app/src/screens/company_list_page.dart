import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistictask/app/src/controllers/company_controllers.dart';
import 'package:joistictask/app/src/screens/company_search_page.dart';

class CompanyListPage extends StatelessWidget {
  final CompanyController companyController = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CompanySearch(companyController));
            },
          ),
        ],
      ),
      body: Obx(() {
        if (companyController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: companyController.companyList.length,
          itemBuilder: (context, index) {
            var company = companyController.companyList[index];
            String title = company['title'].toString().split(" ").take(2).join(" "); // Restrict to 2 words
            String description = company['title'].toString().split(" ").take(5).join(" "); // Short description

            return ListTile(
              leading: Image.network(company['thumbnailUrl'], width: 50, height: 50),
              title: Text(title),
              subtitle: Text(description),
              trailing: Icon(Icons.circle, color: Colors.purple),
              onTap: () => _showCompanyDetail(context, company),
            );
          },
        );
      }),
    );
  }

  // Bottom sheet to show company details
  void _showCompanyDetail(BuildContext context, var company) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.0),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(company['thumbnailUrl'], width: 100, height: 100),
            SizedBox(height: 10),
            Text(
              company['title'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Company description goes here. This is dummy data.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close bottom sheet
                Get.snackbar('Job Application', 'Job Applied Successfully');
              },
              child: Text('Apply Now'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }
}
