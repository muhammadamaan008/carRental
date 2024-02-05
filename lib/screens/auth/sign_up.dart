import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:rental_app/widgets/text_button.dart';
import 'package:rental_app/widgets/text_form_field.dart';
import 'package:sizer/sizer.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late bool _passwordVisible;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? emailValidtaor(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email field cannot be empty';
    } else if (email.isNotEmpty && !EmailValidator.validate(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidtaor(String? password) {
    if (password == null || password.isEmpty) {
      return 'Pasword field cannot be empty';
    } else if (password.isNotEmpty && password.length < 8) {
      return 'Password cannot be less than 8 characters';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/white.png',
              width: 70.w,
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: CustomTextFormField(
                        fieldController: emailController,
                        isTextObscured: false,
                        cursorColor: Colors.white,
                        prefixIcon: const Icon(Icons.email),
                        prefixIconColor: const Color(0xFF46f598),
                        onValidate: emailValidtaor,
                        hintText: 'Email',
                        hintTextColor: const Color.fromARGB(255, 219, 204, 204),
                        textColor: Colors.white,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      child: CustomTextFormField(
                        fieldController: passwordController,
                        isTextObscured: !_passwordVisible,
                        cursorColor: Colors.white,
                        prefixIcon: const Icon(Icons.lock),
                        prefixIconColor: const Color(0xFF46f598),
                        onValidate: passwordValidtaor,
                        hintText: 'Password',
                        hintTextColor: const Color.fromARGB(255, 219, 204, 204),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        textColor: Colors.white,
                        suffixIconColor:
                            const Color.fromARGB(255, 219, 204, 204),
                      ),
                    ),
                    SizedBox(
                      width: 50.w,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 5.w, top: 5.h, right: 5.w),
                        // padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: CustomTextButton(
                          btnText: 'SignUp',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Get.snackbar('Validated', 'Processing Data');
                            }
                          },
                        ),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Text('Already have an account?',
                      style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                  SizedBox(
                    width: 1.w,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/login');
                    },
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white)),
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
