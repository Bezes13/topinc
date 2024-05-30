import 'package:flutter/material.dart';
import 'package:topinc/Pages/login_page.dart';
import 'package:topinc/Themes/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightMode,
      home: LoginPage(),
    );
  }
}
