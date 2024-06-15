import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hint;

  const MyTextField(
      {super.key,
      required this.hintText,
      required this.obscure,
      required this.controller,
      required this.focusNode,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          TextField(
            controller: controller,
            obscureText: obscure,
            focusNode: focusNode,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.tertiary)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.primary)),
                fillColor: Theme.of(context).colorScheme.secondary,
                filled: true,
                hintText: hintText,
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
          if(hint != null)
          Row(
            children: [
              Text("Info: ${hint!}", textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16)),
            ],
          ),
        ],
      ),

    );
  }
}
