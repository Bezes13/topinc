import 'package:flutter/material.dart';
import 'package:topinc/services/auth/auth_service.dart';
import 'package:topinc/components/my_button.dart';
import 'package:topinc/components/my_text_field.dart';

class LoginPage extends StatelessWidget {
  // TextController for E-Mail and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final void Function()? onRegisterTap;

  LoginPage({super.key, required this.onRegisterTap});

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailAndPassword(
          _emailController.text, _pwController.text);
    } catch (e) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
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
            Text("Welcome back, you've been missed!",
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
              hintText: "Password",
              obscure: true,
              controller: _pwController,
              focusNode: null,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(text: "Login", onTap: () => login(context)),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not am member? ",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                GestureDetector(
                    onTap: onRegisterTap,
                    child: Text("Register Now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
