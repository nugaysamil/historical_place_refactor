import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapsuygulama/feature/profile/companenets/profile_edit_about.dart';
import 'package:mapsuygulama/feature/profile/companenets/profile_edit_text.dart';
import 'package:mapsuygulama/product/database/database_service.dart';
import 'package:mapsuygulama/product/database/user_data_service.dart';
import 'package:mapsuygulama/feature/profile/companenets/profile_edit_input_text.dart';
import 'package:mapsuygulama/feature/google/google.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';
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
                                  iconUrl,
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
                            _uploadImage();
                          },
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
                    textController: _nameController,
                  ),
                  SpecialTexts(text: 'location'.tr()),
                  TextInputField(
                    textController: _locationController,
                  ),
                  SpecialTexts(text: 'age'.tr()),
                  TextInputField(
                    textController: _ageController,
                  ),
                ],
              ),
              SizedBox(height: 40),
              Center(
                child: ElevatedButton(
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
                    backgroundColor: Color.fromARGB(255, 32, 144, 236),
                    padding: EdgeInsets.symmetric(horizontal: 140),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(0, 50),
                  ),
                ),
              ),
            ],
          ),
        ),
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
        profile,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  void _uploadImage() async {
    // Fotoğrafı seç ve yükle
    final file = await getImage();

    if (file != null) {
      // İlerleme göstergesini göster
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Fotoğraf yükleniyor..."),
              ],
            ),
          );
        },
        barrierDismissible: false, 
      );

      try {
        final imageUrl = await DatabaseServices.uploadImage(file);

        Navigator.of(context).pop();

        setState(() {
          this.imageUrl = imageUrl;
        });
      } catch (error) {
        Navigator.of(context).pop(); // İlerleme göstergesini kapat
        _showErrorDialog();
      }
    } else {
      _showNoImageSelectedDialog();
    }
  }

  void _showNoImageSelectedDialog() {
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

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hata'),
          content: Text('Fotoğraf yüklenirken bir hata oluştu.'),
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
}
