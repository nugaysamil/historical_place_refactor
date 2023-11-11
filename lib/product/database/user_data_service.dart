import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static Future<void> saveUserData(
      String name, String location, String age, String imageUrl) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'location': location,
          'age': age,
          'imageUrl': imageUrl,
        });

        print('Member registered');
      } else {
        print('User creation error');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
