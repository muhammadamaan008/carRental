import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/models/ad_model.dart';

import 'package:rental_app/screens/post/ad_view_model.dart';
import 'package:rental_app/widgets/radio_list_tile.dart';
import 'package:rental_app/widgets/text_button.dart';

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
  late AdModel adViewModel;
  final _formKey = GlobalKey<FormBuilderState>();
  FuelType? _fuelType;
  Transmission? _transmission;
  String? _dropDownValue;
  String showYear = 'Select Year';
  DateTime? selectedYear;
  // var uuid = Uuid();
  String sessionToken = '11223344';

  final modelController = TextEditingController();
  final rateController = TextEditingController();
  final yearController = TextEditingController();
  final locationController = TextEditingController();

  final Widget spacing = SizedBox(
    height: 2.h,
  );

  bool _submitButtonClicked = false;
  // List<dynamic> placesList =[];
  @override
  void initState() {
    super.initState();
    adViewModel = Provider.of<AdModel>(context, listen: false);
    // locationController.addListener(() {
    //   onChange();
    // });
  }

  // void onChange(){
  //   if(sessionToken == null){
  //     setState(() {
  //       sessionToken = uuid.v4();

  //     });
  //   }
  //   getSuggestion(locationController.text.toString());
  // }

  // void getSuggestion(String input) async{
  //   String placesApiKey = 'AIzaSyBN2UPjz9h7R6W0nQNrXRbDH1tgnN9jRy0';
  //   String baseUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  //   String request = '$baseUrl?input=$input&key=$placesApiKey&sessiontoken=$sessionToken';

  //   var response = await http.get(Uri.parse(request));

  // debugPrint(response.body.toString());
  //   if(response.statusCode == 200){
  //     setState(() {
  //       placesList = jsonDecode(response.body.toString())['predictions'];
  //     });
  //   }else{
  //     throw Exception('Failed to load Data');
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    rateController.dispose();
    yearController.dispose();
    locationController.dispose();
    modelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Consumer<AdModel>(
                builder:
                    (BuildContext context, AdModel adModel, Widget? child) {
                  return FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField(
                          dropdownColor: Colors.grey.shade900,
                          elevation: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Select some role';
                            } else {
                              return null;
                            }
                          },
                          hint: _dropDownValue == null
                              ? Text(
                                  'Choose Company',
                                  style: TextStyle(color: Colors.grey.shade400),
                                )
                              : Text(
                                  _dropDownValue!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: const TextStyle(color: Colors.blue),
                          items: ['Mercedes', 'Suzuki', 'Toyota', 'Bently', 'TATA'].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                  style: TextStyle(color: Colors.grey.shade400),
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
                        spacing,
                        CustomTextFormField(
                            fieldController: modelController,
                            isTextObscured: false,
                            cursorColor: Colors.white,
                            labelText: 'Model',
                            onValidate: adViewModel.modelValidator,
                            hintText: 'e.g Mercedes Benz SClass',
                            hintTextColor: Colors.white,
                            textColor: Colors.white),
                        spacing,
                        InkWell(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Select Year"),
                                  content: SizedBox(
                                    height: 300,
                                    width: 300,
                                    child: YearPicker(
                                        firstDate: DateTime(
                                            DateTime.now().year - 20, 1),
                                        lastDate: DateTime(2025),
                                        selectedDate: null,
                                        onChanged: (DateTime dateTime) {
                                          setState(() {
                                            selectedYear = dateTime;
                                            yearController.text =
                                                selectedYear!.year.toString();
                                            showYear = "${dateTime.year}";
                                          });
                                          Navigator.pop(context);
                                        }),
                                  ),
                                );
                              },
                            );
                          },
                          child: CustomTextFormField(
                              fieldController: yearController,
                              isTextObscured: false,
                              cursorColor: Colors.white,
                              suffixIcon: const Icon(
                                Icons.edit_calendar,
                                color: Colors.white,
                              ),
                              labelText: selectedYear != null
                                  ? selectedYear!.year.toString()
                                  : 'Model Year ',
                              enable: false,
                              onValidate: adViewModel.yearValidator,
                              textColor: Colors.white),
                        ),
                        spacing,
                        Text(
                          'Fuel Type :',
                          style: TextStyle(
                              color: Colors.grey.shade400, fontSize: 12.sp),
                        ),
                        spacing,
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
                        if (_submitButtonClicked && (_fuelType == null))
                          Text('Fuel type cannot be empty',
                              style: TextStyle(
                                  color: Colors.red.shade500, fontSize: 10.sp)),
                        spacing,
                        Text(
                          'Transmission :',
                          style: TextStyle(
                              color: Colors.grey.shade400, fontSize: 12.sp),
                        ),
                        spacing,
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
                        if (_submitButtonClicked && (_transmission == null))
                          Text(
                            'Transmission type cannot be empty',
                            style: TextStyle(
                                color: Colors.red.shade500, fontSize: 10.sp),
                          ),
                        spacing,
                        CustomTextFormField(
                            fieldController: rateController,
                            isTextObscured: false,
                            cursorColor: Colors.white,
                            labelText: 'Rate/Day',
                            keyboardType: TextInputType.number,
                            onValidate: adViewModel.rateValidator,
                            hintText: 'e.g 10000 in PKR',
                            hintTextColor: Colors.grey,
                            textColor: Colors.white),
                        spacing,
                        CustomTextFormField(
                            fieldController: locationController,
                            isTextObscured: false,
                            cursorColor: Colors.white,
                            labelText: 'Location',
                            onValidate: adViewModel.locationValidator,
                            hintText: 'e.g ABC colony lahore',
                            hintTextColor: Colors.grey,
                            textColor: Colors.white),
                        spacing,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Images',
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                adViewModel.getImagesFromGallery();
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        spacing,
                        Container(
                          height: 35.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Colors.grey.shade800, width: 0.5),
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 2.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 2.h,
                              mainAxisSpacing: 3.w,
                              crossAxisCount: 2,
                            ),
                            itemCount: adModel.images?.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 20.sp,
                                child: Container(
                                  padding: EdgeInsets.all(2.sp),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade900,
                                      border: Border.all(
                                          color: Colors.grey.shade800,
                                          width: 0.5),
                                      borderRadius:
                                          BorderRadius.circular(10.sp)),
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      child: Image.file(adModel.images![index],
                                          fit: BoxFit.contain)),
                                ),
                              );
                            },
                          ),
                        ),
                        spacing,
                        SizedBox(
                          width: 100.w,
                          height: 6.h,
                          child: CustomTextButton(
                            btnText: 'Submit',
                            loading: adModel.loading,
                            onPressed: () {
                              setState(() {
                                _submitButtonClicked = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                var postAd = Ad(
                                    fuelType:
                                        _fuelType.toString().split('.').last,
                                    transmission: _transmission
                                        .toString()
                                        .split('.')
                                        .last,
                                    model: modelController.text.toString(),
                                    rates: int.parse(
                                        rateController.text.toString()),
                                    location:
                                        locationController.text.toString(),
                                    year: selectedYear!.year.toString(),
                                    make: _dropDownValue.toString(),
                                    timeStamp: DateTime.timestamp(),
                                    uId:
                                        FirebaseAuth.instance.currentUser!.uid);
                                adViewModel.uploadAdToDatabase(postAd);
                                adViewModel.images?.clear();
                              }
                            },
                          ),
                        ),
                        spacing,
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
