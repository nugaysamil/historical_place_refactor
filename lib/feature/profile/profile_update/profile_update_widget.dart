import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mapsuygulama/product/database/database_service.dart';
import 'package:mapsuygulama/feature/google/marker_list.dart';
import 'package:mapsuygulama/product/database/user_data_service.dart';
import 'package:mapsuygulama/feature/google/google.dart';


class ProfileEditUpdate extends StatefulWidget {
  const ProfileEditUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileEditUpdate> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEditUpdate> {
  bool isObscurePassword = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final bool isPasswordTextField = false;

  String? imageUrl;

  @override
  void initState() {
    super.initState();
    readUserData();
  }

  Future<void> readUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        final userData = snapshot.data()!;
        setState(() {
          _nameController.text = userData['name'] ?? '';
          _locationController.text = userData['location'] ?? '';
          _ageController.text = userData['age'] ?? '';
          imageUrl = userData['imageUrl'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomMarkerInfoWindow(
                          markers: markers,
                          customInfoWindowController:
                              customInfoWindowController,
                        )));
          },
        ),
        backgroundColor: const Color.fromARGB(0, 81, 56, 56),
        title: Text('Profile Edit'),
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
                                  'https://e7.pngegg.com/pngimages/382/874/png-clipart-user-profile-computer-icons-female-person-office-lady-purple-business-woman.png',
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
                          color: Colors.blue.shade400,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.add_a_photo),
                          color: Colors.white,
                          onPressed: () async {
                            XFile? file = await getImage();
                            if (file != null) {
                              final imageUrl =
                                  await DatabaseServices.uploadImage(file);
                              setState(
                                () {
                                  this.imageUrl = imageUrl;
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
              textFieldControllers(
                  _nameController, 'Name', 'Name Giriniz', 'Name Boş Olamaz'),
              textFieldControllers(_locationController, 'Location',
                  'Location Giriniz', 'Location Boş Olamaz'),
              textFieldControllers(
                  _ageController, 'Age', 'Age Giriniz', 'Age boş olamaz'),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel'.toUpperCase(),
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
                    onPressed: () {
                      FirebaseService.saveUserData(
                        _nameController.text,
                        _ageController.text,
                        _locationController.text,
                        imageUrl!,
                      );
                    },
                    child: Text(
                      'save'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
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

  Future<XFile?> getImage() async {
    final picker = ImagePicker();

    return await picker.pickImage(
      source: ImageSource.gallery,
    );
  }
}
