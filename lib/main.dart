import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'theme_state.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeStride',

      // Light Theme
      theme: lightTheme,

      // Dark Theme
      darkTheme: darkTheme,

      // Controlled by Provider
      themeMode: context.watch<ThemeState>().mode,

      home: const HomeScreen(),
    );
  }
}