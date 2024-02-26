import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/screens/auth/auth_view_model.dart';
import 'package:rental_app/screens/post/ad_view_model.dart';
import 'package:rental_app/utils/constants.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    adViewModel = Provider.of<AdModel>(context, listen: false);
    authModel = Provider.of<AuthModel>(context, listen: false);
    initializeData();
  }

  Future<void> initializeData() async {
    await adViewModel.getAllAdData();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdModel>(
      builder: (BuildContext context, AdModel value, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: isLoading
              ? SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.red),
                      Text(
                        'Loading Ads',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              : value.adData.isEmpty
                  ? const SizedBox(
                      child: Center(
                        child: Text(
                          'No Ad Posted Yet',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 1.h),
                          child: SizedBox(
                            height: 6.h,
                            child: TextField(
                              onChanged: (String enterChar) {
                                adViewModel.searchPerson(enterChar);
                              },
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.sp),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                label: const Text('Search'),
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                suffixIcon: const Icon(Icons.search),
                                suffixIconColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1)),
                                hintStyle: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: GridView.builder(
                            itemCount: value.adData.length,
                            itemBuilder: (context, index) {
                              final ad = value.adData[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.carDetails, arguments: ad);
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                ad.rates.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                            SizedBox(width: 2.w),
                                            authModel.isUserBuyer
                                                ? InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.sp),
                                                    onTap: () {
                                                      adViewModel
                                                          .toggleFavourite(
                                                              index);
                                                    },
                                                    child: Icon(
                                                      value.adData[index].isFav
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border_outlined,
                                                      color: Colors.white,
                                                    ))
                                                : const SizedBox()
                                          ],
                                        ),
                                      ),
                                      Image.network(
                                        ad.images != null &&
                                                ad.images!.isNotEmpty
                                            ? ad.images![0]
                                            : AppConstants.defaultImageUrl,
                                        height: 20.h,
                                        width: 100.w,
                                        fit: BoxFit.contain,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                ad.model,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, mainAxisExtent: 30.h),
                          ),
                        )
                      ],
                    ),
        );
      },
    );
  }
}
