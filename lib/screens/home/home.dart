import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/screens/post/ad_view_model.dart';
import 'package:rental_app/screens/post/add_post.dart';
import 'package:rental_app/screens/post/fav_posts.dart';
import 'package:rental_app/screens/home/home_view.dart';
import 'package:rental_app/screens/profile/settings.dart';
import 'package:rental_app/screens/video.dart';
import 'package:rental_app/utils/constants.dart';
import 'package:rental_app/widgets/app_bar.dart';
import 'package:sizer/sizer.dart';

import '../auth/auth_view_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  late AuthModel authModel;
  late AdModel adViewModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    authModel = Provider.of<AuthModel>(context, listen: false);
    adViewModel = Provider.of<AdModel>(context, listen: false);
    initializeData();
  }

  Future<void> initializeData() async {
    await authModel.authoriseBuyer();
    await authModel.getCredentials();
    await adViewModel.getAllAdData();
    await adViewModel.getAdsFromFavourites();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CustomAppBar(
          title: "Hi, ${authModel.userDisplayName}",
          centerTitle: true,
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,
          backArrow: false,
        ),
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
            : currentIndex == 0
                ? const HomeView()
                : currentIndex == 2
                    ? const Video()
                    : currentIndex == 3
                        ? const Settings()
                        : currentIndex == 1 && authModel.isUserBuyer
                            ? const Favourites()
                            : const AddPost(),
        bottomNavigationBar: GNav(
          onTabChange: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          backgroundColor: Colors.grey.shade900,
          color: Colors.white,
          gap: 5.sp,
          activeColor: Colors.grey.shade900,
          tabBackgroundColor: AppConstants.mainColor,
          tabBorderRadius: 100.sp,
          tabMargin: EdgeInsets.only(
            top: 5.sp,
            bottom: 5.sp,
            left: 2.sp,
            right: 2.sp,
          ),
          style: GnavStyle.google,
          padding: EdgeInsets.all(10.sp),
          textSize: 100.sp,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: [
            const GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            authModel.isUserBuyer
                ? const GButton(
                    icon: Icons.favorite,
                    text: 'Fav',
                  )
                : const GButton(
                    icon: Icons.add_box,
                    text: 'Add Post',
                  ),
            const GButton(
              icon: Icons.video_call,
              text: 'Video',
            ),
            const GButton(
              icon: Icons.settings,
              text: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
