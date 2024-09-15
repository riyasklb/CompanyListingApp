import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyDetailPage extends StatefulWidget {
  final String companyName;
  final String companyDescription;
  final String companyImageUrl;
  final bool hasApplied;
  final VoidCallback onApply;

  CompanyDetailPage({
    required this.companyName,
    required this.companyDescription,
    required this.companyImageUrl,
    required this.onApply,
    required this.hasApplied,
  });

  @override
  _CompanyDetailPageState createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> {
  late bool _hasApplied;

  @override
  void initState() {
    super.initState();
    _hasApplied = widget.hasApplied;
  }

  void _applyForJob() {
    setState(() {
      _hasApplied = true;
    });
    widget.onApply();
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  String getFirstTwoWords(String input) {
    List<String> words = input.split(' ');
    if (words.length > 2) {
      words = words.sublist(0, 2);
    }
    words = words.map((word) {
      return word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : word;
    }).toList();
    return words.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  getFirstTwoWords(widget.companyName),
                  style: GoogleFonts.montserrat(
                    fontSize: 24.sp, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Chennai', // Static location text
                  style: GoogleFonts.montserrat(
                    fontSize: 17.sp, // Responsive font size
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  capitalizeFirstLetter(widget.companyDescription),
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp, // Responsive font size
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  capitalizeFirstLetter("Position"),
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  capitalizeFirstLetter(widget.companyName),
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp, // Responsive font size
                    color: Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  capitalizeFirstLetter("Qualifications"),
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  capitalizeFirstLetter(widget.companyDescription),
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp, // Responsive font size
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: _hasApplied
                ? ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      textStyle: GoogleFonts.montserrat(fontSize: 18.sp),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: Text(
                      'Applied',
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  )
                : ElevatedButton(
                    onPressed: _applyForJob,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6C63FF),
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.r),
                      ),
                      elevation: 5,
                      shadowColor: Colors.blueAccent,
                    ),
                    child: Text(
                      'APPLY NOW',
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
