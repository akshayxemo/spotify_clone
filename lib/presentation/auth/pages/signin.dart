import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone/core/config/assets/app_vectors.dart';
import 'package:spotify_clone/core/config/theme/app_colors.dart';
import 'package:spotify_clone/data/models/auth/signin_user_req.dart';
import 'package:spotify_clone/domain/usecases/auth/signin.dart';
import 'package:spotify_clone/presentation/auth/pages/signup.dart';
import 'package:spotify_clone/presentation/root/pages/root.dart';
import 'package:spotify_clone/service_locator.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 30,
          width: 30,
        ),
      ),
      bottomNavigationBar: _registerNowText(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(
              height: 30,
            ),
            _userNameOrEmailField(context),
            const SizedBox(
              height: 20,
            ),
            _passwordField(context),
            const SizedBox(
              height: 20,
            ),
            BasicAppButton(
                onPressed: () async {
                  var result = await serviceLocator<SigninUseCase>().call(
                    params: SigninUserReq(
                      email: _email.text.toString(),
                      password: _password.text.toString(),
                    ),
                  );

                  result.fold((ifLeft) {
                    var snackBar = SnackBar(content: Text(ifLeft));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }, (ifRight) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const RootPage(),
                      ),
                      (route) => false,
                    );
                  });
                },
                title: "Sign In")
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      "Sign In",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      textAlign: TextAlign.center,
    );
  }

  Widget _userNameOrEmailField(BuildContext context) {
    return TextField(
      controller: _email,
      cursorColor: context.isDarkMode ? Colors.white : AppColors.gray,
      decoration: const InputDecoration(hintText: "Enter Username Or Email")
          .applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      cursorColor: context.isDarkMode ? Colors.white : AppColors.gray,
      decoration:
          const InputDecoration(hintText: "Enter Password").applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _registerNowText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Not a member ?",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SignupPage(),
                ),
              );
            },
            child: const Text(
              "Register Now",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
