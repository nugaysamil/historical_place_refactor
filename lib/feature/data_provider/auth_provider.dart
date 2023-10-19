import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsuygulama/feature/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authRepositoryProvider).authStateChange;
});
