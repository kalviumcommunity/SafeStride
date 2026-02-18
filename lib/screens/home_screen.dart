import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 🔹 Existing Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('Go to Second Screen'),
            ),

            const SizedBox(height: 20),

            // 🔹 NEW State Management Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/state');
              },
              child: const Text('Go to State Management Demo'),
            ),

          ],
        ),
      ),
    );
  }
}
