import 'package:flutter/material.dart';
import 'package:topinc/services/auth/auth_service.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';

class RegisterPage extends StatelessWidget {
  // TextController for E-Mail and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();
  final void Function()? onLoginTap;

  RegisterPage({super.key, required this.onLoginTap});

  void register(BuildContext context) {
    final auth = AuthService();
    if (_pwController.text == _pwConfirmController.text) {
      try {
        auth.signUpWithEmailAndPassword(
            _emailController.text, _pwController.text, _userNameController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords don't match"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message,
                size: 60, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 50),
            Text("Create your Account",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16)),
            const SizedBox(
              height: 25,
            ),
            MyTextField(
              hintText: "Email",
              obscure: false,
              controller: _emailController,
              focusNode: null,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              hintText: "Username",
              obscure: false,
              controller: _userNameController,
              focusNode: null,
              hint: "The name everyone else sees",
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              hintText: "Password",
              obscure: true,
              controller: _pwController,
              focusNode: null,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              hintText: "Confrim Password",
              obscure: true,
              controller: _pwConfirmController,
              focusNode: null,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(text: "Register", onTap: () => register(context)),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                GestureDetector(
                  onTap: onLoginTap,
                  child: Text("Login now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
