import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Responsive Layout")),
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // HEADER
            Container(
              width: double.infinity,
              height: 120,
              color: Colors.blue,
              child: const Center(child: Text("Header")),
            ),

            const SizedBox(height: 12),

            // MAIN AREA
            Expanded(
              child: screenWidth < 600

                  // 📱 SMALL SCREEN → vertical layout
                  ? Column(
                      children: [
                        Expanded(child: panel("Left Panel", Colors.orange)),
                        const SizedBox(height: 10),
                        Expanded(child: panel("Right Panel", Colors.green)),
                      ],
                    )

                  // 💻 LARGE SCREEN → horizontal layout
                  : Row(
                      children: [
                        Expanded(child: panel("Left Panel", Colors.orange)),
                        const SizedBox(width: 10),
                        Expanded(child: panel("Right Panel", Colors.green)),
                      ],
                    ),
            ),

            const SizedBox(height: 12),

            // FOOTER
            Container(
              height: 70,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child: Text("Footer", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget panel(String text, Color color) {
    return Container(
      color: color,
      child: Center(child: Text(text)),
    );
  }
}
