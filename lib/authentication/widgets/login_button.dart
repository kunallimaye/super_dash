import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_dash/authentication/authentication.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GameIconButton(
      icon: Icons.login_rounded,
      onPressed: () => Navigator.of(context).push(UserLoginDialog.route()),
    );
  }
}
