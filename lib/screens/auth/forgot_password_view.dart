import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/screens/auth/auth_view_model.dart';
import 'package:rental_app/utils/constants.dart';
import 'package:rental_app/utils/routes.dart';
import 'package:rental_app/widgets/app_bar.dart';
import 'package:rental_app/widgets/text_button.dart';
import 'package:rental_app/widgets/text_form_field.dart';
import 'package:sizer/sizer.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});
  

  @override
  Widget build(BuildContext context) {
    final AuthModel authModel =
        Provider.of<AuthModel>(context, listen: false);

    final forgotFieldController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final Widget spacing = SizedBox(
      height: 2.h,
    );

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: const CustomAppBar(
              title: 'Cardez',
              centerTitle: false,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
          body: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 25.sp),
                  ),
                  spacing,
                  Text(
                    'Enter the email you registered with and we will send you a link to reset your password',
                    style: TextStyle(color: Colors.white,fontSize: 12.sp),
                  ),
                  spacing,
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          fieldController: forgotFieldController,
                          isTextObscured: false,
                          cursorColor: Colors.white,
                          prefixIcon: const Icon(Icons.lock_open),
                          prefixIconColor: Colors.grey,
                          onValidate: authModel.emailValidator,
                          hintText: 'Enter your email',
                          hintTextColor: Colors.white,
                          textColor: Colors.white,
                          underlineColor: Colors.white,
                        ),
                        spacing,
                        SizedBox(
                          width: 100.w,
                          child: CustomTextButton(
                            btnText: 'Get Link',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                authModel.sendEmail(forgotFieldController.value.text.toString());
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  spacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New to Cardez?',
                            style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                        SizedBox(
                          width: 1.w,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.signUp);
                          },
                          child: Text('Sign Up',
                              style: TextStyle(
                                  color: AppConstants.mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppConstants.mainColor)),
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
