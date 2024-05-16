import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/models/ad_model.dart';
import 'package:rental_app/screens/auth/auth_view_model.dart';
import 'package:rental_app/screens/post/ad_view_model.dart';
import 'package:rental_app/service/snack_bar.dart';
import 'package:rental_app/utils/constants.dart';
import 'package:rental_app/widgets/app_bar.dart';
import 'package:sizer/sizer.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  double currentIndex = 0;
  dynamic argumentData = Get.arguments;
  late Ad ad;
  final CarouselController _controller = CarouselController();
  late AuthModel authModel;
  late AdModel adModel;
  final Widget spacing = SizedBox(
    height: 1.h,
  );

  @override
  void initState() {
    super.initState();
    ad = argumentData as Ad;
    authModel = Provider.of<AuthModel>(context, listen: false);
    adModel = Provider.of<AdModel>(context, listen: false);
  }

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
                          child: CarouselSlider(
                            carouselController: _controller,
                            options: CarouselOptions(
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index.toDouble();
                                });
                              },
                            ),
                            items: ad.images != null && ad.images!.isNotEmpty
                                ? ad.images!
                                    .map((item) => Image.network(
                                          item,
                                          fit: BoxFit.contain,
                                          width: 100.w,
                                          height: 100.h,
                                        ))
                                    .toList()
                                : [
                                    Image.network(
                                      AppConstants.defaultImageUrl,
                                      fit: BoxFit.contain,
                                      width: 100.w,
                                      height: 100.h,
                                    )
                                  ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: ad.images != null && ad.images!.isNotEmpty
                              ? ad.images!.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () =>
                                        _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: 3.w,
                                      height: 3.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 1.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            AppConstants.mainColor.withOpacity(
                                          currentIndex == entry.key ? 0.9 : 0.4,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList()
                              : [
                                  GestureDetector(
                                    onTap: () => _controller.animateToPage(0),
                                    child: Container(
                                      width: 3.w,
                                      height: 3.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 1.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            AppConstants.mainColor.withOpacity(
                                          currentIndex == 0 ? 0.9 : 0.4,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Text(
                            ad.year,
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w, bottom: 1.h),
                          child: Text(
                            ad.model,
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
                      Text(
                        'Make',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        ad.make,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
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
                                Text(
                                  'Transmission',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  ad.transmission,
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                            Center(
                                child: VerticalDivider(
                              color: Colors.grey.shade400,
                            )),
                            Column(
                              children: [
                                Text(
                                  'Fuel Type',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  ad.fuelType,
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
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
                GestureDetector(
                  onTap: () {
                    CustomSnackBar.showSnackBar(
                        'Attention', 'Feature to be added later');
                  },
                  child: Card(
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
                          padding: EdgeInsets.only(left: 2.w, top: 0.5.h),
                          child: Text(
                            'Location',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 1.h),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.sp),
                              child: Image.asset(
                                'assets/images/mapPic.png',
                                fit: BoxFit.cover,
                                height: 20.h,
                                width: 100.w,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Text(
                            'KB Colony New Airport Road Lahore Near Chughtai Lab Lahore',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 2.w, right: 2.w, bottom: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '12Km',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text('14min',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                spacing,
                GestureDetector(
                  onTap: () {
                    authModel.isUserBuyer
                        ? CustomSnackBar.showSnackBar(
                            'Attention', 'Feature to be added later')
                        : adModel.deleteAdById(ad.adId!);
                  },
                  child: Consumer<AdModel>(
                    builder:
                        (BuildContext context, AdModel value, Widget? child) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.sp),
                          color: authModel.isUserBuyer
                              ? AppConstants.mainColor
                              : Colors.red,
                        ),
                        height: 6.h,
                        child: value.loading
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: Colors.black, strokeWidth: 2.sp),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: Text('${ad.rates} PKR/a day',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 2.w),
                                    child: Text(
                                        authModel.isUserBuyer
                                            ? 'Book'
                                            : 'Delete',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500)),
                                  )
                                ],
                              ),
                      );
                    },
                  ),
                ),
                spacing
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
