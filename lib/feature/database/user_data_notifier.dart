import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDataNotifier extends StateNotifier<UserData> {
  UserDataNotifier() : super(UserData()) {
    readUserData();
  }

  Future<void> readUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          final userData = snapshot.data();

          if (userData != null) {
            String name = userData['name'];
            String location = userData['location'];
            String age = userData['age'];
            String imageUrl = userData['imageUrl'];

            state = UserData(
              name: name,
              location: location,
              age: age,
              imageUrl: imageUrl,
            );
          }
        } else {
          print('User data not found');
        }
      } else {
        print('User not logged in');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> readImage() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        String filePath = 'users/$userId/';
        Reference ref = FirebaseStorage.instance.ref().child(filePath);
        String downloadURL = await ref.getDownloadURL();

        state = state.copyWith(imageURL: downloadURL);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
