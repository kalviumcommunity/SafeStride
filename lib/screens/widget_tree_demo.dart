import 'package:flutter/material.dart';

class WidgetTreeDemo extends StatefulWidget {
  const WidgetTreeDemo({super.key});

  @override
  State<WidgetTreeDemo> createState() => _WidgetTreeDemoState();
}

class _WidgetTreeDemoState extends State<WidgetTreeDemo> {

  int count = 0;

  void increase() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Widget Tree Demo"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(Icons.flutter_dash, size: 80),

            const SizedBox(height: 20),

            Text(
              "Count = $count",
              style: const TextStyle(fontSize: 28),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: increase,
              child: const Text("Increment"),
            ),

          ],
        ),
      ),
    );
  }
}
