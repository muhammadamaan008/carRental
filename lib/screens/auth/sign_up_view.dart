import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/screens/auth/auth_view_model.dart';
import 'package:rental_app/service/snack_bar.dart';
import 'package:rental_app/utils/constants.dart';
import 'package:rental_app/widgets/app_bar.dart';
import 'package:rental_app/widgets/radio_list_tile.dart';
import 'package:rental_app/widgets/text_button.dart';
import 'package:rental_app/widgets/text_form_field.dart';
import 'package:sizer/sizer.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

enum SingingCharacter { buyer, seller }

class _SignUpState extends State<SignUp> {
  late AuthModel authModel;
  late bool _passwordVisible;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  SingingCharacter? _character = SingingCharacter.buyer;
  final Widget spacing = SizedBox(
    height: 2.h,
  );

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    authModel = Provider.of<AuthModel>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: const CustomAppBar(
            title: 'Cardez',
            centerTitle: false,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
          ),
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/white.png',
                  ),
                  spacing,
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            fieldController: nameController,
                            isTextObscured: false,
                            cursorColor: Colors.white,
                            prefixIcon: const Icon(Icons.person),
                            prefixIconColor: const Color(0xFF46f598),
                            onValidate: authModel.nameValidator,
                            hintText: 'Your Full Name',
                            hintTextColor:
                                const Color.fromARGB(255, 219, 204, 204),
                            textColor: Colors.white,
                          ),
                          spacing,
                          CustomTextFormField(
                            fieldController: emailController,
                            isTextObscured: false,
                            cursorColor: Colors.white,
                            prefixIcon: const Icon(Icons.email),
                            prefixIconColor: const Color(0xFF46f598),
                            onValidate: authModel.emailValidator,
                            hintText: 'Email',
                            hintTextColor:
                                const Color.fromARGB(255, 219, 204, 204),
                            textColor: Colors.white,
                          ),
                          spacing,
                          CustomTextFormField(
                            fieldController: passwordController,
                            isTextObscured: !_passwordVisible,
                            cursorColor: Colors.white,
                            prefixIcon: const Icon(Icons.lock),
                            prefixIconColor: const Color(0xFF46f598),
                            onValidate: authModel.passwordValidator,
                            hintText: 'Password',
                            hintTextColor:
                                const Color.fromARGB(255, 219, 204, 204),
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
                          spacing,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomRadioListTile<SingingCharacter?>(
                                radioValue: SingingCharacter.seller,
                                groupValue: _character,
                                text: "Seller",
                                onChange: (value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                               CustomRadioListTile<SingingCharacter?>(
                                radioValue: SingingCharacter.buyer,
                                groupValue: _character,
                                text: "Buyer",
                                onChange: (value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          spacing,
                          SizedBox(
                            width: 100.w,
                            height: 6.h,
                            child: Consumer<AuthModel>(
                              builder: (BuildContext context, AuthModel obj,
                                  Widget? child) {
                                return CustomTextButton(
                                  loading: obj.loading,
                                  btnText: 'SignUp',
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      CustomSnackBar.showSnackBar(
                                          'Please wait', 'Processing started.');
                                      authModel.createUserWithEmailAndPassword(
                                          emailController.value.text.toString(),
                                          passwordController.value.text
                                              .toString(),
                                          _character.toString().split('.').last,
                                          nameController.value.text.toString());
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      )),
                  spacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp)),
                      SizedBox(
                        width: 1.w,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed('/login');
                        },
                        child: Text('Login',
                            style: TextStyle(
                              color: AppConstants.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              decoration: TextDecoration.underline,
                              decorationColor: AppConstants.mainColor,
                            )),
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
