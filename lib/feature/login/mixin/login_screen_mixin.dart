// ignore_for_file: invalid_use_of_visible_for_testing_member, unused_local_variable

part of 'login_screen_page.dart';

mixin LoginScreenMixin on State<LoginInpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginInButton(BuildContext context, WidgetRef ref) async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      LoginStateError('Please enter email and password.');
    } else {
      try {
        final email = _emailController.text;
        final password = _passwordController.text;

        final methods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        if (methods.isNotEmpty) {
          final loginController = ref.read(loginControllerProvider.notifier);
          await loginController.userLogin(email, password);

          Fluttertoast.showToast(
            msg: msgLogInSucces,
            toastLength: Toast.LENGTH_SHORT,
          );

          Future.delayed(
            Duration(milliseconds: 700),
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileEdit(),
                ),
              );
            },
          );
        } else {
          LoginStateError('Lütfen mail ve şifrenizi tekrar girip deneyiniz.');
        }
      } catch (e) {
        LoginStateError('Invalid email or password.');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
