import 'package:flutter/material.dart';
import 'package:topinc/Pages/login_page.dart';
import 'package:topinc/Pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onRegisterTap: togglePage,
      );
    } else {
      return RegisterPage(
        onLoginTap: togglePage,
      );
    }
  }
}
