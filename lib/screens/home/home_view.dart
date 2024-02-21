import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/screens/auth/auth_view_model.dart';
import 'package:rental_app/screens/post/ad_view_model.dart';
import 'package:rental_app/utils/routes.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late AdModel adViewModel;
  late AuthModel authModel;

  @override
  void initState() {
    super.initState();
    adViewModel = Provider.of<AdModel>(context, listen: false);
    authModel = Provider.of<AuthModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Flexible(
            child: Consumer<AdModel>(
              builder: (BuildContext context, AdModel value, Widget? child) {
                return GridView.builder(
                  itemCount: value.itemData.length,
                  itemBuilder: (context, index) {
                    final ad = value.itemData[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.carDetails);
                      },
                      child: Card(
                        elevation: 5.sp,
                        color: Colors.grey.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            width: 1,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      ad.rate.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  authModel.isUserBuyer
                                      ? InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          onTap: () {
                                            value.toggleFavourite(index);
                                          },
                                          child: Icon(
                                            value.itemData[index].isFav
                                                ? Icons.favorite
                                                : Icons.favorite_border_outlined,
                                            color: Colors.white,
                                          ))
                                      : const SizedBox()
                                  // authModel.isUserBuyer
                                  //     ? IconButton(
                                  //         padding: EdgeInsets.zero,
                                  //         onPressed: () {
                                  //           value.toggleFavourite(index);
                                  //         },
                                  //         icon: Icon(
                                  //           value.itemData[index].isFav
                                  //               ? Icons.favorite
                                  //               : Icons
                                  //                   .favorite_border_outlined,
                                  //           color: Colors.white,
                                  //           size: 18.sp,
                                  //         ),
                                  //       )
                                  //     : Padding(
                                  //         padding: EdgeInsets.symmetric(
                                  //             vertical: 2.5.h)),
                                ],
                              ),
                            ),
                            Image.network(
                              ad.imageUrl!,
                              height: 20.h,
                              width: 100.w,
                              fit: BoxFit.contain,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      ad.model,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    ad.year,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 30.h),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
