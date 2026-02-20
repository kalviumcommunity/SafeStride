import 'package:flutter/material.dart';

class StatelessStatefulDemo extends StatelessWidget {
  const StatelessStatefulDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stateless vs Stateful Demo"),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DemoHeader(),   // Stateless Widget
            SizedBox(height: 30),
            CounterWidget(), // Stateful Widget
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////
/// 1️⃣ Stateless Widget (Static Header)
//////////////////////////////////////////////////////////

class DemoHeader extends StatelessWidget {
  const DemoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Interactive Counter App",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

//////////////////////////////////////////////////////////
/// 2️⃣ Stateful Widget (Dynamic Counter)
//////////////////////////////////////////////////////////

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int count = 0;

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Count: $count",
          style: const TextStyle(fontSize: 22),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: incrementCounter,
          child: const Text("Increase"),
        ),
      ],
    );
  }
}
