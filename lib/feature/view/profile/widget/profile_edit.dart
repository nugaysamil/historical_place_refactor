import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mapsuygulama/feature/view/profile/widget/profile_edit_view_mixin.dart';
import 'package:mapsuygulama/feature/view/profile/widget/text/profile_edit_about_text.dart';
import 'package:mapsuygulama/feature/view/profile/widget/text/profile_edit_text.dart';
import 'package:mapsuygulama/feature/view/profile/widget/text/profile_edit_input_text.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';

class ProfileEdit extends StatefulWidget {
  ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> with ProfileEditViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 40, right: 15),
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
                            color: Colors.black.withOpacity(0.4),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageUrl != null
                              ? NetworkImage(imageUrl!)
                              : NetworkImage(
                                  StringConstants.iconUrl,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
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
                          icon: Icon(Icons.add_a_photo),
                          color: Colors.white,
                          onPressed: selectAndUploadImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AboutMeWidget(),
                  SpecialTexts(text: 'name_surname'.tr()),
                  TextInputField(
                    textController: nameController,
                  ),
                  SpecialTexts(text: 'location'.tr()),
                  TextInputField(
                    textController: locationController,
                  ),
                  SpecialTexts(text: 'age'.tr()),
                  TextInputField(
                    textController: ageController,
                  ),
                ],
              ),
              SizedBox(height: 40),
              Center(
                child: _saveButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _saveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        saveUserData();
      },
      child: Text(
        'save'.tr().toUpperCase(),
        style: TextStyle(
          fontSize: 15,
          letterSpacing: 2,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 120),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(10, 50),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.black38,
        onPressed: () {},
      ),
      title: Text(
        StringConstants.profile,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
