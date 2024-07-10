import 'dart:ui';

import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_dash/constants/constants.dart';
import 'package:super_dash/gen/assets.gen.dart';
import 'package:super_dash/l10n/l10n.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserLoginDialog extends StatelessWidget {
  UserLoginDialog({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static PageRoute<void> route() {
    return HeroDialogRoute(
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: UserLoginDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bodyStyle = AppTextStyles.bodyLarge;
    const highlightColor = Color(0xFF9CECCD);
    final authenticationRepository = context.select(
      (AuthenticationRepository authRepo) => authRepo,
    );
    final linkStyle = AppTextStyles.bodyLarge.copyWith(
      color: highlightColor,
      decoration: TextDecoration.underline,
      decorationColor: highlightColor,
    );
    return AppDialog(
      border: Border.all(color: Colors.white24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          Assets.images.gameLogo.image(width: 230),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Text(
                  l10n.loginSuperDash,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: 'Username'),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GameElevatedButton(
                  label: 'Sign In',
                  onPressed: () {
                    authenticationRepository
                        .signInWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                        )
                        .then(Navigator.of(context).pop);
                  },
                  // () {
                  //   Navigator.of(context).pop;
                  //   // await authenticationRepository.signInWithEmailAndPassword(
                  //   //   _emailController.text,
                  //   //   _passwordController.text,
                  //   // );
                  //   // await Navigator.of(context).pop;
                  // },
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFA6C3DF),
                      Color(0xFF79AACA),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Register',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launchUrlString(Urls.githubRepo),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // _handleLogin(context) {
  //   Navigator.of(context).pop;
  // }
}
