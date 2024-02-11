import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/widgets/text_form_field.dart';
import 'package:sizer/sizer.dart';

import '../service/auth_view_model.dart';
import '../widgets/text_button.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    AuthModel authModel = AuthModel();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final Widget spacing = SizedBox(
      height: 2.h,
    );
    nameController.text = authModel.displayName!;
    emailController.text = authModel.email!;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Container(
              color: Colors.yellow,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Card(
                  color: Colors.red,
                  elevation: 5.sp,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        spacing,
                        CustomTextFormField(
                          fieldController: nameController,
                          isTextObscured: false,
                          cursorColor: Colors.white,
                          prefixIcon: const Icon(Icons.person),
                          prefixIconColor: const Color(0xFF46f598),
                          onValidate:
                          Provider.of<AuthModel>(context, listen: false)
                              .nameValidator,
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
                          onValidate:
                          Provider.of<AuthModel>(context, listen: false)
                              .nameValidator,
                          hintText: 'Email',
                          hintTextColor:
                          const Color.fromARGB(255, 219, 204, 204),
                          textColor: Colors.white,
                        ),
                        spacing,
                        SizedBox(
                          width: double.infinity, // Use maximum available width
                          child: Consumer<AuthModel>(
                            builder: (BuildContext context, AuthModel obj,
                                Widget? child) {
                              return CustomTextButton(
                                loading: obj.loading,
                                btnText: 'Update',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    // Handle form submission
                                    authModel.updateUserCredentials(emailController.text.toString(), nameController.text.toString(),null);
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
        ),
      ),
    );
  }
}

