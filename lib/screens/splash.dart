import 'package:flutter/material.dart';
import 'package:rental_app/widgets/app_bar.dart';
import 'package:sizer/sizer.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(
        title: 'Sasti Swari',
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Container(
        // color: Colors.red,
        height: double.maxFinite,
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF434144),
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 0.5.h, horizontal: 3.5.w),
                      child: Text(
                        'Search',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF434144),
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 0.5.h, horizontal: 3.5.w),
                      child: Text(
                        'Compare',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF434144),
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 0.5.h, horizontal: 3.5.w),
                      child: Text(
                        'Hire',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Text('Find the ideal car rental for your trip!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 2.h,
              ),
              Text(
                  'Get access to the best deals from global car rental companies.',
                  style: TextStyle(color: Colors.white, fontSize: 12.sp)),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                width: double.maxFinite,
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF46f598))),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
