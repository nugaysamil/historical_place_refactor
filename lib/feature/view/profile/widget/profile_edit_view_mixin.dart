import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapsuygulama/feature/view/google/custom_widget.dart';
import 'package:mapsuygulama/product/database/database_service.dart';
import 'package:mapsuygulama/product/utils/image_util.dart';
import 'package:mapsuygulama/product/database/user_data_service.dart';
import 'package:easy_localization/easy_localization.dart';

mixin ProfileEditViewMixin<T extends StatefulWidget> on State<T> {
  String? imageUrl;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get locationController => _locationController;
  TextEditingController get ageController => _ageController;

  Future<void> selectAndUploadImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    final file = await ImageSelector().getImage();
    await Future.delayed(Duration(seconds: 10));  

    Navigator.pop(context);

    if (file != null) {
      final imageUrl = await DatabaseServices.uploadImage(file);
      setState(() {
        this.imageUrl = imageUrl;
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Lütfen başka bir fotoğraf seçin.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  void saveUserData() {
    if (_nameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _ageController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'all_information_required'.tr(),
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
          msg: 'age_area'.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      } else {
        if (imageUrl == null) {
          Fluttertoast.showToast(
            msg: "select_image".tr(),
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
            imageUrl.toString(),
          ).then((value) {
            Fluttertoast.showToast(
              msg: 'correct_data'.tr(),
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
                    builder: (context) => CustomMarkerInfoWindow(),
                  ),
                );
              },
            );
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _ageController.dispose();
    super.dispose();
  }
}
