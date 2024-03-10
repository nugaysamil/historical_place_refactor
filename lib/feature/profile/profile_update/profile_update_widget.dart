import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mapsuygulama/product/database/database_service.dart';
import 'package:mapsuygulama/product/database/user_data_service.dart';
import 'package:mapsuygulama/feature/google/custom_widget.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';

part 'profile_update_widget.mixin.dart';

class ProfileEditUpdate extends StatefulWidget {
  const ProfileEditUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileEditUpdate> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEditUpdate>
    with ProfileEditUpdateMixin {
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomMarkerInfoWindow(),
              ),
            );
          },
        ),
        backgroundColor: const Color.fromARGB(0, 81, 56, 56),
        title: Text(
          "profile_edit".tr(),
          style: TextStyle(color: Colors.black),
        ),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageUrl != null
                              ? NetworkImage(imageUrl!)
                              : NetworkImage(
                                  networkImage
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 3,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          color: Colors.black,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                          ),
                          color: Colors.white,
                          onPressed: () => getImageUtils(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              textFieldControllers(_nameController, 'name_surname'.tr(),
                  'Name Giriniz', 'Name Boş Olamaz'),
              textFieldControllers(_locationController, "location".tr(),
                  'Location Giriniz', 'Location Boş Olamaz'),
              textFieldControllers(
                  _ageController, 'age'.tr(), 'Age Giriniz', 'Age boş olamaz'),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      'cancel'.tr(),
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => saveUserDataController(),
                    child: Text(
                      'SAVE2'.tr(),
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldControllers(TextEditingController selectedController,
      String selectedLabelText, String selectedHintText, String errorText) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 30,
      ),
      child: TextField(
        controller: selectedController,
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(
                      () {
                        isObscurePassword = !isObscurePassword;
                      },
                    );
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: selectedLabelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: selectedHintText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          errorText: errorText.isEmpty ? 'Age boş olamaz' : null,
        ),
      ),
    );
  }

  
}
