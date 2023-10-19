import 'package:firebase_auth/firebase_auth.dart';
import 'package:mapsuygulama/feature/repository/auth_repository.dart';

class EmailValidator {
  
  static Future<List<String>> fetchSignInMethodsForEmail(String email) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return userCredential;
    } catch (error) {
      throw AuthException('Error checking email: $error');
    }
  }
}
