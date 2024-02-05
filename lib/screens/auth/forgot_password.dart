import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:rental_app/utils/routes.dart';
import 'package:rental_app/widgets/text_button.dart';
import 'package:rental_app/widgets/text_form_field.dart';
import 'package:sizer/sizer.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});
  String? emailValidtaor(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email field cannot be empty';
    } else if (email.isNotEmpty && !EmailValidator.validate(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final forgotFieldController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 8.h),
              child:  Text(
                'Forgot Password?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
              child:  Text(
                'Enter the email you registered with and we will send you a link to reset your password',
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: CustomTextFormField(
                        fieldController: forgotFieldController,
                        isTextObscured: false,
                        cursorColor: Colors.white,
                        prefixIcon: const Icon(Icons.lock_open),
                        prefixIconColor: Colors.grey,
                        onValidate: emailValidtaor,
                        hintText: 'Enter your email',
                        hintTextColor: Colors.black,
                        textColor: Colors.black,
                        underlineColor: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: CustomTextButton(
                        btnText: 'Forgot Password',
                        onPressed: () {
                          // To Be Defined Earlier
                          if (formKey.currentState!.validate()) {
                            Get.snackbar('Validated', 'Processing Data');
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New to Cardez?',
                        style: TextStyle(color: Colors.black, fontSize: 12.sp)),
                    SizedBox(
                      width: 1.w,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.signUp);
                      },
                      child: Text('Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black)),
                    )
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}
