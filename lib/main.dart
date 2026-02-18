import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/second_screen.dart';
import 'screens/scrollable_views.dart';
import 'screens/state_management_demo.dart';   // ✅ NEW IMPORT

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scrollable Views App',

      initialRoute: '/',

      routes: {
        '/': (context) => const HomeScreen(),
        '/second': (context) => const SecondScreen(),
        '/scrollable': (context) => const ScrollableViews(),
        '/state': (context) => const StateManagementDemo(),  // ✅ NEW ROUTE
      },
    );
  }
}
