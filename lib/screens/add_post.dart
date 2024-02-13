import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_app/widgets/radio_list_tile.dart';
import 'package:rental_app/widgets/text_form_field.dart';
import 'package:sizer/sizer.dart';

enum FuelType { petrol, diesel }

enum Transmission { automatic, manual }

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();
  final modelController = TextEditingController();
  FuelType? _fuelType;
  Transmission? _transmission;
  String? _dropDownValue;
  String showYear = 'Select Year';
  DateTime selectedYear = DateTime.now();

  List<File> images = [];
  final picker = ImagePicker();

  Future<void> getImagesFromGallery() async {
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        images =
            pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
      });
    } else {
      print('No Images Picked');
    }
  }

  selectYear(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Select Year'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String? nameValidator(String? name) {
      RegExp nameRegExp = RegExp('[0-9]');
      if (name == null || name.isEmpty) {
        return 'Name field cannot be empty';
      } else if (name.isNotEmpty && name.contains(nameRegExp)) {
        return 'Name cannot have numbers';
      }
      return null;
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                              fieldController: modelController,
                              isTextObscured: false,
                              cursorColor: Colors.white,
                              labelText: 'Enter Model',
                              onValidate: nameValidator,
                              hintText: 'e.g Mercedes Benz SClass',
                              hintTextColor: Colors.white,
                              textColor: Colors.white),
                          CustomTextFormField(
                              fieldController: modelController,
                              isTextObscured: false,
                              cursorColor: Colors.white,
                              labelText: 'Rate/Day',
                              onValidate: nameValidator,
                              hintText: 'e.g 10000 in PKR',
                              hintTextColor: Colors.grey,
                              textColor: Colors.white),
                          // Container(
                          //   child: Row(

                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomRadioListTile<FuelType?>(
                                radioValue: FuelType.diesel,
                                groupValue: _fuelType,
                                text: "Diesel",
                                onChange: (value) {
                                  setState(() {
                                    _fuelType = value;
                                  });
                                },
                              ),
                              CustomRadioListTile<FuelType?>(
                                radioValue: FuelType.petrol,
                                groupValue: _fuelType,
                                text: "Petrol",
                                onChange: (value) {
                                  setState(() {
                                    _fuelType = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          DropdownButton(
                            dropdownColor: Colors.grey.shade900,
                            elevation: 5,
                            hint: _dropDownValue == null
                                ? Text(
                                    'Choose Company',
                                    style:
                                        TextStyle(color: Colors.grey.shade400),
                                  )
                                : Text(
                                    _dropDownValue!,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: const TextStyle(color: Colors.blue),
                            items: ['One', 'Two', 'Three'].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(
                                    val,
                                    style:
                                        TextStyle(color: Colors.grey.shade400),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  _dropDownValue = val;
                                },
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomRadioListTile<Transmission?>(
                                radioValue: Transmission.automatic,
                                groupValue: _transmission,
                                text: "Automatic",
                                onChange: (value) {
                                  setState(() {
                                    _transmission = value;
                                  });
                                },
                              ),
                              CustomRadioListTile<Transmission?>(
                                radioValue: Transmission.manual,
                                groupValue: _transmission,
                                text: "Manual",
                                onChange: (value) {
                                  setState(() {
                                    _transmission = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Images',
                                style: TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {
                                  getImagesFromGallery();
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      )),
                  Container(
                    color: Colors.transparent,
                    height: 35.h,
                    width: 100.w,
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 2.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2.h,
                        mainAxisSpacing: 3.w,
                        crossAxisCount: 2,
                      ),
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 20.sp,
                          child: Container(
                            padding: EdgeInsets.all(2.sp),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                border: Border.all(
                                    color: Colors.grey.shade800, width: 0.5),
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.sp),
                                child: Image.file(images[index],
                                    fit: BoxFit.contain)),
                          ),
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
    );
  }
}
