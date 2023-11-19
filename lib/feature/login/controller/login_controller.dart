import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../product/data_provider/auth_provider.dart';
import 'login_state.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  Future<void> userLogin(
      String email, String password) async {
    ref.read(loginControllerProvider.notifier).state =
        const LoginStateLoading();
    try {
      await ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(email, password);
      ref.read(loginControllerProvider.notifier).state =
          const LoginStateSuccess();
    } catch (e) {
      ref.read(loginControllerProvider.notifier).state =
          LoginStateError('eeee'.toString());
    }
  }

  Future<void> createUser(String email, String password) async {
    state = LoginStateLoading();

    try {
      final user = await ref
          .read(authRepositoryProvider)
          .createUserWithEmailAndPassword(email, password);
      print('Create User Id: ${user?.uid}');

      state = LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});
