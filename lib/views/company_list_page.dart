import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistictask/controllers/company_controllers.dart';
import 'package:joistictask/models/get_job_model.dart';
import 'package:joistictask/views/company_details_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joistictask/views/company_search_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CompanyListPage extends StatelessWidget {
  final CompanyController companyController = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.h, bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.black),
                    onPressed: () {},
                    iconSize: 24.w,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(233, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.r),
                      ),
                      elevation: 0.5,
                    ),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CompanySearchDelegate(companyController),
                      );
                    },
                    child: Icon(
                      Icons.search_outlined,
                      color: Colors.grey[800],
                      size: 24.w,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Find your Dream\nJob today',
                  style: GoogleFonts.montserrat(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            GetBuilder<CompanyController>(
              init: companyController,
              builder: (controller) {
                if (controller.isLoading) {
                  return Expanded(
                    child: Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        itemCount: 6,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Container(
                              height: 80.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.companyList.length,
                    itemBuilder: (context, index) {
                      var company = controller.companyList[index];
                      String title = toBeginningOfSentenceCase(
                            company.title.split(" ").take(2).join(" "),
                          ) ??
                          company.title;
                      String description = toBeginningOfSentenceCase(
                            company.title.split(" ").take(5).join(" "),
                          ) ??
                          company.title;
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
                                offset: Offset(0, 4),
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
                                  backgroundImage:
                                      NetworkImage(company.thumbnailUrl),
                                  backgroundColor: Colors.grey[200],
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
                            trailing: GestureDetector(
                              onTap: () => _showCompanyDetail(context, company),
                              child: CircleAvatar(
                                backgroundColor: company.applied
                                    ? Colors.green
                                    : Colors.blue,
                                child: Icon(
                                  company.applied ? Icons.check : Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
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
                  topRight: Radius.circular(15.r))),
          child: Stack(alignment: Alignment.bottomCenter, children: [
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
          ]),
        );
      },
    );
  }
}
