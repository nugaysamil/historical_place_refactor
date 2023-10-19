import 'package:cloud_firestore/cloud_firestore.dart';

enum FirestoreCollections {
  favorites,
}

class FirestoreUtils {
  static CollectionReference getCollectionRef(String collectionName) {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(collectionName);

    return collectionRef;
  }
}
