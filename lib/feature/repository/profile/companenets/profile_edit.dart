import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapsuygulama/feature/database/database_service.dart';
import 'package:mapsuygulama/feature/database/user_data_service.dart';
import 'package:mapsuygulama/feature/repository/profile/companenets/profile_edit_input_text.dart';
import 'package:mapsuygulama/google.dart';
import 'package:mapsuygulama/marker_list.dart';
import 'package:mapsuygulama/product/utils/image_util.dart';


class ProfileEdit extends StatefulWidget {
  ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
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
                                  'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png',
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
                            color: Colors.black),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                          ),
                          color: Colors.white,
                          onPressed: () async {
                            final file = await getImage();
                            if (file != null) {
                              final imageUrl =
                                  await DatabaseServices.uploadImage(file);
                              setState(() {
                                this.imageUrl = imageUrl;
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Fotoğraf Seçilmedi'),
                                    content: Text('Lütfen bir fotoğraf seçin.'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Tamam'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              TextInputField(
                textController: _nameController,
                labelText: 'name_surname'.tr(),
              ),
              TextInputField(
                textController: _locationController,
                labelText: 'location'.tr(),
              ),
              TextInputField(
                textController: _ageController,
                labelText: 'age'.tr(),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isEmpty ||
                          _locationController.text.isEmpty ||
                          _ageController.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'Lütfen tüm alanları doldurunuz.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        );
                      } else {
                        int? age = int.tryParse(_ageController.text);
                        if (age == null) {
                          Fluttertoast.showToast(
                            msg: 'Yaş alanına geçerli bir sayı giriniz.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                          );
                        } else {
                          FirebaseService.saveUserData(
                                  _nameController.text,
                                  _locationController.text,
                                  age.toString(),
                                  imageUrl.toString())
                              .then(
                            (value) {
                              Fluttertoast.showToast(
                                msg: 'Verileriniz doğru kaydedilmiştir.',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              );
                              Future.delayed(
                                Duration(seconds: 2),
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustomMarkerInfoWindow(
                                        markers: markers,
                                        customInfoWindowController:
                                            customInfoWindowController,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Text(
                      'kaydet'.tr().toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
