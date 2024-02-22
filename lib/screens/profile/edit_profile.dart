import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/utils/constants.dart';
import 'package:rental_app/widgets/app_bar.dart';
import 'package:rental_app/widgets/text_form_field.dart';
import 'package:sizer/sizer.dart';

import '../auth/auth_view_model.dart';
import '../../widgets/text_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late AuthModel authModel;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final Widget spacing = SizedBox(
    height: 2.h,
  );
  String? imageString;

  @override
  void initState() {
    super.initState();
    authModel = Provider.of<AuthModel>(context, listen: false);
    nameController.text = authModel.userDisplayName!;
    emailController.text = authModel.userEmail!;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }

  // To Be Written in view model
  File? image;
  final picker = ImagePicker();
  Future getImageFromGallery() async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      } else {
        debugPrint('No Image Picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'Update Profile',
            centerTitle: false,
            backgroundColor: Colors.grey.shade900,
            foregroundColor: Colors.white,
          ),
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    spacing,
                    InkWell(
                      onTap: () {
                        getImageFromGallery();
                      },
                      child: CircleAvatar(
                        maxRadius: 35.sp,
                        backgroundColor: Colors.transparent,
                        backgroundImage: image != null
                            ? FileImage(image!) as ImageProvider<Object>?
                            : authModel.userPhotoUrl != null
                                ? NetworkImage(authModel.userPhotoUrl!)
                                : const NetworkImage(
                                    'https://st.depositphotos.com/2934765/53192/v/450/depositphotos_531920820-stock-illustration-photo-available-vector-icon-default.jpg'),
                        child: Align(
                          alignment: Alignment.bottomRight,
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
                    CustomTextFormField(
                      fieldController: nameController,
                      isTextObscured: false,
                      cursorColor: Colors.white,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: const Color(0xFF46f598),
                      onValidate: Provider.of<AuthModel>(context, listen: false)
                          .nameValidator,
                      hintText: 'Your Full Name',
                      hintTextColor: const Color.fromARGB(255, 219, 204, 204),
                      textColor: Colors.white,
                    ),
                    spacing,
                    CustomTextFormField(
                      fieldController: emailController,
                      isTextObscured: false,
                      cursorColor: Colors.white,
                      prefixIcon: const Icon(Icons.email),
                      prefixIconColor: const Color(0xFF46f598),
                      onValidate: Provider.of<AuthModel>(context, listen: false)
                          .emailValidator,
                      hintText: 'Email',
                      hintTextColor: const Color.fromARGB(255, 219, 204, 204),
                      textColor: Colors.white,
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
                            btnText: 'Update',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (image != null) {
                                  final downloadUrl = await authModel
                                      .uploadImageToStorage(image!);
                                  if (downloadUrl != null) {
                                    authModel.updateUserCredentials(
                                      email: emailController.text.toString(),
                                      name: nameController.text.toString(),
                                      photoURL: downloadUrl,
                                    );
                                  }
                                } else {
                                  authModel.updateUserCredentials(
                                    email: emailController.text.toString(),
                                    name: nameController.text.toString(),
                                  );
                                }
                              }
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
