import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/screens/auth/auth_view_model.dart';
import 'package:rental_app/screens/post/ad_view_model.dart';
import 'package:sizer/sizer.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  late AuthModel authModel;
  late AdModel adModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    authModel = Provider.of<AuthModel>(context, listen: false);
    adModel = Provider.of<AdModel>(context, listen: false);
    initializeData();
  }

  Future<void> initializeData() async {
    await adModel.getAdsFromFavourites();
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
                        'Loading Fav Ads',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              : value.itemData.isEmpty
                  ? const SizedBox(
                      child: Center(
                        child: Text(
                          'No Data to Display',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Flexible(
                          child: GridView.builder(
                            itemCount: value.itemData.length,
                            itemBuilder: (context, index) {
                              final ad = value.itemData[index];
                              return GestureDetector(
                                onTap: () {
                                  adModel.moveToDetailScreen(
                                      value.itemData[index].adId);
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
                                                ad.rate.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                            SizedBox(width: 2.w),
                                            InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.sp),
                                                onTap: () {
                                                  value.removeFromFavourites(
                                                      ad.adId, ad.buyerId);
                                                },
                                                child: const Icon(
                                                  Icons.favorite,
                                                  color: Colors.white,
                                                ))
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
