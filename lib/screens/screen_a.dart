import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import 'screen_b.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ["Helmet", "Gloves", "Jacket", "Boots"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen A - Add Favorites"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ScreenB()),
              );
            },
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),

            trailing: ElevatedButton(
              onPressed: () {
                context.read<FavoritesProvider>().addFavorite(items[index]);
              },
              child: const Text("Add"),
            ),
          );
        },
      ),
    );
  }
}
