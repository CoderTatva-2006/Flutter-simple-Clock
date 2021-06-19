import 'widgets.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() => {runApp(Ontime())};

class Ontime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(),
      dark: ThemeData.dark(),
      initial: AdaptiveThemeMode.dark, 
      builder: (theme,darkTheme)=>
      MaterialApp(
      title: "Ontime",
      theme: theme,
      darkTheme: darkTheme,
      home: main_window()
      )
    );
  }
}
