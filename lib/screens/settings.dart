import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/service/auth_view_model.dart';
import 'package:rental_app/utils/constants.dart';
import 'package:rental_app/widgets/text_button.dart';
import 'package:sizer/sizer.dart';

import '../utils/routes.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    AuthModel authModel = Provider.of<AuthModel>(context, listen: false);
    final Widget spacing = SizedBox(
      height: 0.5.h,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          spacing,
          CircleAvatar(
            maxRadius: 35.sp,
            backgroundColor: Colors.transparent,
            // backgroundImage: const NetworkImage(
            //     'https://st.depositphotos.com/2934765/53192/v/450/depositphotos_531920820-stock-illustration-photo-available-vector-icon-default.jpg'),
            backgroundImage: authModel.photoUrl != null
                ? NetworkImage(authModel.photoUrl!)
                : const NetworkImage(
                    'https://st.depositphotos.com/2934765/53192/v/450/depositphotos_531920820-stock-illustration-photo-available-vector-icon-default.jpg'),
            child: Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                onTap: () {
                  print('amana');
                },
                child: CircleAvatar(
                  maxRadius: 10.sp,
                  backgroundColor: AppConstants.mainColor,
                  child: Icon(
                    Icons.edit,
                    size: 13.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          spacing,
          Text(
            authModel.displayName!,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 12.sp),
          ),
          spacing,
          Text(authModel.email!, style: TextStyle(color: Colors.white,fontSize: 10.sp)),
          spacing,
          CustomTextButton(btnText: 'Edit Profile', onPressed: (){
            Get.toNamed(Routes.editProfile);
          },),
          spacing,
           Divider(color: Colors.grey.shade900,thickness: 1.sp,),
          ListTile(
            title: const Text('Terms & Condition'),
            textColor: Colors.white,
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Get.toNamed(Routes.termsAndCondition);
            },
          ),
          Divider(color: Colors.grey.shade900,thickness: 1.sp,),
          ListTile(
            title: const Text('Privacy Policy'),
            textColor: Colors.white,
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Get.toNamed(Routes.privacy);
            },
          ),
          Divider(color: Colors.grey.shade900,thickness: 1.sp,),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            textColor: Colors.red,
            onTap: () {
              Get.defaultDialog(
                title: 'Confirmation',
                middleText: 'Are you sure you want to logout?',
                textConfirm: 'Ok',
                buttonColor: Colors.grey.shade900,
                onConfirm: () async {
                  //To Be Written
                  authModel.logout();
                },
              );
            },
          )
        ],
      ),
    );
  }
}
