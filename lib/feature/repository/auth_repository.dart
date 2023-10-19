// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';


class AuthRepository {
  const AuthRepository(
    this._auth,
  );

  final FirebaseAuth _auth;

  Stream<User?> get authStateChange => _auth.authStateChanges();

 Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      print(result);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Kullanıcı bulunamadı, giriş yapılmayacak.');
        return null;
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong Password');
      } else {
        throw AuthException('An error occurred. Please try again later');
      }
    }
  }


 Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(user);
      return user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('User not found');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong Password');
      } else {
        throw AuthException('An error occurred. Please try again later');
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}
