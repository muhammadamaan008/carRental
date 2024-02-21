import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/utils/constants.dart';
import 'package:rental_app/widgets/app_bar.dart';
import 'package:rental_app/widgets/text_button.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  double currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Car Detail',
          centerTitle: true,
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        width: 1,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex = index.toDouble();
                                    });
                                  },
                                ),
                                items: imgList
                                    .map((item) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.5.w),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.sp),
                                            child: Image.network(
                                              item,
                                              fit: BoxFit.cover,
                                              width: 100.w,
                                              height: 100.h,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                              Positioned(
                                left: 30.w,
                                bottom: 0.5.h,
                                child: SmoothIndicator(
                                  offset: currentIndex,
                                  count: imgList.length,
                                  effect: WormEffect(
                                    activeDotColor: AppConstants.mainColor,
                                    dotHeight: 1.h,
                                    dotWidth: 3.w,
                                    type: WormType.thinUnderground,
                                  ),
                                  size: Size(0.1.w, 0.1.h),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w, top: 1.h),
                          child: Text(
                            '2021',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w, bottom: 1.h),
                          child: Text(
                            'Mercedes Benz A Class',
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    )),
                Card(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      width: 1,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                       Text('Make', style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600, fontWeight: FontWeight.w600),),
                      Text('Mercedes',style: TextStyle(fontSize: 11.sp, color: Colors.white, fontWeight: FontWeight.w300),),
                      Divider(
                        indent: 10.sp,
                        endIndent: 10.sp,
                        color: Colors.grey.shade400,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                             Column(
                              children: [
                                Text('Transmission', style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600, fontWeight: FontWeight.w600),),
                                Text('Autmocatic',style: TextStyle(fontSize: 11.sp, color: Colors.white, fontWeight: FontWeight.w300),)
                              ],
                            ),
                            Center(
                                child: VerticalDivider(
                              color: Colors.grey.shade400,
                            )),
                             Column(
                              children: [
                                Text('Fuel Type', style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600, fontWeight: FontWeight.w600),),
                             Text('Diesel',style: TextStyle(fontSize: 11.sp, color: Colors.white, fontWeight: FontWeight.w300),)],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      )
                    ],
                  ),
                ),
                 SizedBox(
                  width: 100.w,
                  child: const CustomTextButton(btnText: 'Book'),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
