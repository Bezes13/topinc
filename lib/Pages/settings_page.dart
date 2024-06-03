import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topinc/Themes/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Dark Mode"),
            CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context).isDarkMode,
                onChanged: (_) => {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme()
                    })
          ],
        ),
      ),
    );
  }
}
