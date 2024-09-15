import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joistictask/controllers/company_controllers.dart';
import 'package:joistictask/models/get_job_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joistictask/views/company_details_page.dart';

class CompanySearchDelegate extends SearchDelegate {
  final CompanyController companyController;

  CompanySearchDelegate(this.companyController);

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchResults = companyController.companyList
        .where((company) =>
            company.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        var company = searchResults[index];
        String title =
            capitalizeFirstLetter(company.title.split(" ").take(2).join(" "));
        String description =
            capitalizeFirstLetter(company.title.split(" ").take(5).join(" "));

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: GetBuilder<CompanyController>(builder: (_) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.w),
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36.r),
                    color: Colors.grey[100],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2.0.w),
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundImage: NetworkImage(
                        company.thumbnailUrl,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                subtitle: Text(
                  description,
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(
                  Icons.circle,
                  color: company.applied ? Colors.green : Colors.purple,
                ),
                onTap: () {
                  close(context, null);
                  _showCompanyDetail(context, company);
                },
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = companyController.companyList
        .where((company) =>
            company.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return GetBuilder<CompanyController>(builder: (_) {
      return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          var company = suggestions[index];
          String title =
              capitalizeFirstLetter(company.title.split(" ").take(2).join(" "));
          String description =
              capitalizeFirstLetter(company.title.split(" ").take(5).join(" "));

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.w),
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36.r),
                    color: Colors.grey[100],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2.0.w),
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundImage: NetworkImage(
                        company.thumbnailUrl,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                subtitle: Text(
                  description,
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(
                  Icons.circle,
                  color: company.applied ? Colors.green : Colors.purple,
                ),
                onTap: () {
                  query = title;
                  _showCompanyDetail(context, company);
                },
              ),
            ),
          );
        },
      );
    });
  }

  void _showCompanyDetail(BuildContext context, GetJobModel company) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 600.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                child: Transform.translate(
                  offset: Offset(
                    -114.w,
                    -380.h,
                  ),
                  child: CircleAvatar(
                    radius: 70.r,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(company.thumbnailUrl),
                      radius: 55.r,
                    ),
                  ),
                ),
              ),
              CompanyDetailPage(
                companyName: company.title,
                companyDescription: 'Dummy description for ${company.title}',
                companyImageUrl: company.thumbnailUrl,
                hasApplied: company.applied,
                onApply: () {
                  companyController.applyForJob(company.id);
                  Get.back();
                  Get.snackbar('Success', 'Job Applied Successfully');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
