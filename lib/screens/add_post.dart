import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:rental_app/widgets/text_form_field.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final modelController = TextEditingController();

    String? nameValidator(String? name) {
      RegExp nameRegExp = RegExp('[0-9]');
      if (name == null || name.isEmpty) {
        return 'Name field cannot be empty';
      } else if (name.isNotEmpty && name.contains(nameRegExp)) {
        return 'Name cannot have numbers';
      }
      return null;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Form(
             key: _formKey,
              child: Column(
              children: [
                CustomTextFormField(
                    fieldController: modelController,
                    isTextObscured: false,
                    // cursorColor: cursorColor,
                    // prefixIcon: Icons.,
                    // prefixIconColor: prefixIconColor,
                    onValidate: nameValidator,
                    hintText: 'Enter Model e.g Mercedes Benz SClass',
                    hintTextColor: Colors.white,
                    textColor: Colors.white)
              ],
          ))
        ],
      ),
    );
  }
}
