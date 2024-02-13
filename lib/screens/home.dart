import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/screens/add_post.dart';
import 'package:rental_app/screens/fav_posts.dart';
import 'package:rental_app/screens/home_view.dart';
import 'package:rental_app/screens/profile/settings.dart';
import 'package:rental_app/screens/video.dart';
import 'package:rental_app/utils/constants.dart';
import 'package:rental_app/widgets/app_bar.dart';
import 'package:sizer/sizer.dart';

import '../service/auth_view_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [
    const HomeView(),
    const AddPost(),
    const Favourites(),
    const Settings()
  ];
  late AuthModel auth = Provider.of<AuthModel>(context, listen: false);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: "Hi, ${auth.userDisplayName}",
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
      ),
      body: currentIndex == 0
          ? const HomeView()
          : currentIndex == 2
              ? const Video()
              : currentIndex == 3
                  ? const Settings()
                  : currentIndex == 1 && auth.isUserBuyer
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
          tabMargin:
              EdgeInsets.only(top: 5.sp, bottom: 5.sp, left: 2.sp, right: 2.sp),
          style: GnavStyle.google,
          padding: EdgeInsets.all(10.sp),
          textSize: 100.sp,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: [
            const GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            auth.isUserBuyer
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
          ]),
    ));
  }
}
