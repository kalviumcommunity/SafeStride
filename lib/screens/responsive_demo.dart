import 'package:flutter/material.dart';

class ResponsiveDemo extends StatelessWidget {
  const ResponsiveDemo({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Responsive Demo")),

      body: LayoutBuilder(
        builder: (context, constraints) {
          // 📱 MOBILE LAYOUT
          if (constraints.maxWidth < 600) {
            return Center(
              child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.2,
                color: Colors.teal,
                child: const Center(
                  child: Text(
                    "Mobile Layout",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
            );
          }
          // 💻 TABLET LAYOUT
          else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: screenWidth * 0.3,
                  height: 150,
                  color: Colors.orange,
                  child: const Center(child: Text("Left Panel")),
                ),

                Container(
                  width: screenWidth * 0.3,
                  height: 150,
                  color: Colors.teal,
                  child: const Center(child: Text("Right Panel")),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
