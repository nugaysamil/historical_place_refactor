// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DatabaseServices {
  static Future<String> uploadImage(XFile? imageFile) async {
    if (imageFile == null) {
      throw Exception("Resim seçilmedi.");
    }

    File file = File(imageFile.path);
    print(file);

    String fileName = basename(file.path);

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("There are no user.");
    }

    String userId = user.uid;
    String filePath = 'users/$userId/$fileName';

    Reference ref = FirebaseStorage.instance.ref().child(filePath);

    UploadTask task = ref.putFile(file);

    TaskSnapshot snapshot = await task.whenComplete(() => print('OK'));

    return await snapshot.ref.getDownloadURL();
  }
}

Future<String> uploadImageToFirebaseStorage(File imageFile) async {
  final firebase_storage.Reference storageRef =
      firebase_storage.FirebaseStorage.instance.ref().child('images');

  final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  final firebase_storage.UploadTask uploadTask =
      storageRef.child(fileName).putFile(imageFile);

  final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
  final String downloadURL = await taskSnapshot.ref.getDownloadURL();

  return downloadURL;
}
