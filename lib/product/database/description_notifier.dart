import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../enums/firebase_collections_enum.dart';
import '../models/favorite_models.dart';

class FavoritesStateNotifier extends StateNotifier<List<Favorite>> {
  FavoritesStateNotifier() : super([]);

  Future<void> readFromFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final String userId = user.uid;
        final CollectionReference collectionRef =
            FirestoreUtils.getCollectionRef('favorites');

        final snapshot = await collectionRef.doc(userId).get();
        if (snapshot.exists) {
          final snapshotData = snapshot.data() as Map<String, dynamic>?;
          if (snapshotData != null && snapshotData.containsKey('favorites')) {
            final favoriteDataList =
                List<Map<String, dynamic>>.from(snapshotData['favorites']);

            state = favoriteDataList
                .map((favoriteData) => Favorite.fromMap(favoriteData))
                .toList();
          } else {
            state = [];
          }
        } else {
          state = [];
        }
      } else {
        state = [];
      }
    } catch (error) {
      print('Hata: $error');
    } finally {}
  }

  Future<void> writeToFirestore(
      String markerList, Map<String, dynamic> data) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String userId = user.uid;
      final CollectionReference collectionRef =
          FirestoreUtils.getCollectionRef('favorites');

      final newFavorite = Favorite(
        name: markerList,
        image: data['image'],
        information: data['information'].toString(),
      );

      bool isDataExists = state.any((favorite) =>
          favorite.name == newFavorite.name &&
          favorite.image == newFavorite.image &&
          favorite.information == newFavorite.information);

      if (!isDataExists) {
        state = [...state, newFavorite];
        await collectionRef.doc(userId).set({
          'favorites': state.map((favorite) => favorite.toMap()).toList(),
        });
      }

    } else {
      Fluttertoast.showToast(
        msg: "required_login".tr(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  Future<void> deleteFromFirestore(Map<String, dynamic> dataToRemove) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String userId = user.uid;
      final CollectionReference collectionRef =
          FirestoreUtils.getCollectionRef('favorites');

      final snapshot = await collectionRef.doc(userId).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('favorites')) {
          final favoriteList =
              List<Map<String, dynamic>>.from(data['favorites']);
          favoriteList.removeWhere((item) =>
              item['name'] == dataToRemove['name'] &&
              item['image'] == dataToRemove['image'] &&
              item['information'] == dataToRemove['information']);
          await collectionRef.doc(userId).set({
            'favorites': favoriteList,
          });
        }
      }
    }
  }
}
