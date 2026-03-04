import 'dart:async';
import 'package:flutter/material.dart';

class LiveItemsViewer extends StatefulWidget {
  const LiveItemsViewer({super.key});

  @override
  State<LiveItemsViewer> createState() => _LiveItemsViewerState();
}

class _LiveItemsViewerState extends State<LiveItemsViewer> {
  late Future<List<String>> _itemsFuture;


  bool simulateError = false;
  bool simulateEmpty = false;

  @override
  void initState() {
    super.initState();
    _itemsFuture = fetchItems();
  }

  Future<List<String>> fetchItems() async {
    await Future.delayed(const Duration(seconds: 2));

    if (simulateError) {
      throw Exception("Failed to fetch items");
    }

    if (simulateEmpty) {
      return [];
    }

    return ["Item 1", "Item 2", "Item 3"];
  }

  void retry() {
    setState(() {
      _itemsFuture = fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Items Viewer"),
      ),
      body: FutureBuilder<List<String>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          
          // 🔵 LOADING STATE
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // 🔴 ERROR STATE
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Something went wrong.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: retry,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          // 🟡 EMPTY STATE
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No items found.\nAdd your first item!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // 🟢 DATA STATE
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
              );
            },
          );
        },
      ),
    );
  }
}