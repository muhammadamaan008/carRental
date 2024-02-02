import 'package:flutter/material.dart';
import 'package:rental_app/widgets/app_bar.dart';
import 'package:rental_app/widgets/text_button.dart';
import 'package:sizer/sizer.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 3), () => Get.toNamed('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(
        title: 'Cardez',
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Container(
                padding: EdgeInsets.only(right: 20.w),
                child: Image.asset(
                  'assets/images/car2.png',
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF434144),
                        borderRadius: BorderRadius.circular(5.sp)),
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
                        borderRadius: BorderRadius.circular(5.sp)),
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
                        borderRadius: BorderRadius.circular(5.sp)),
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
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text('Find the ideal car rental for your trip!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                  'Get access to the best deals from global car rental companies.',
                  style: TextStyle(color: Colors.white, fontSize: 12.sp)),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: CustomTextButton(
                  btnText: "Get Started",
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
