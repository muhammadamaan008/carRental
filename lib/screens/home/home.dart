import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/screens/post/ad_view_model.dart';
import 'package:rental_app/screens/post/add_post.dart';
import 'package:rental_app/screens/post/fav_posts.dart';
import 'package:rental_app/screens/post/view_posts.dart';
import 'package:rental_app/screens/settings/settings_view.dart';
import 'package:rental_app/screens/advertisement/video.dart';
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
  late AdModel adModel;

  @override
  void initState() {
    super.initState();
    authModel = Provider.of<AuthModel>(context, listen: false);
    adModel = Provider.of<AdModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthModel>(
        builder: (BuildContext context, AuthModel value, Widget? child) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: CustomAppBar(
              title: "Hi, ${FirebaseAuth.instance.currentUser!.displayName}",
              centerTitle: true,
              backgroundColor: Colors.grey.shade900,
              foregroundColor: Colors.white,
              backArrow: false,
            ),
            body: Column(
              children: [
                currentIndex == 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.w, vertical: 1.h),
                        child: SizedBox(
                          height: 6.h,
                          child: TextField(
                            onChanged: (String enterChar) {
                              adModel.searchPerson(enterChar);
                            },
                            style:
                                TextStyle(color: Colors.white, fontSize: 10.sp),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              label: const Text('Search'),
                              labelStyle: const TextStyle(color: Colors.white),
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
                      )
                    : const SizedBox(),
                Expanded(
                  child: currentIndex == 0
                      ? const HomeView()
                      : currentIndex == 2
                          ? const Video()
                          : currentIndex == 3
                              ? const Settings()
                              : currentIndex == 1 && value.isUserBuyer
                                  ? const Favourites()
                                  : const AddPost(),
                ),
              ],
            ),
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
                value.isUserBuyer
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
          );
        },
      ),
    );
  }
}
