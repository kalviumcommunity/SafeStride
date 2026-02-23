import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  final TextEditingController _routeNameController =
      TextEditingController();
  final TextEditingController _routeDistanceController =
      TextEditingController();

  @override
  void dispose() {
    _routeNameController.dispose();
    _routeDistanceController.dispose();
    super.dispose();
  }

  Future<void> _showAddRouteDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Route'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _routeNameController,
              decoration: const InputDecoration(
                labelText: 'Route Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _routeDistanceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Distance (km)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_routeNameController.text.isNotEmpty &&
                  _routeDistanceController.text.isNotEmpty) {
                await _firestoreService.addRoute({
                  'name': _routeNameController.text,
                  'distance': double.parse(
                      _routeDistanceController.text),
                  'createdAt':
                      DateTime.now().toIso8601String(),
                  'createdBy':
                      FirebaseAuth.instance.currentUser?.uid,
                });

                _routeNameController.clear();
                _routeDistanceController.clear();

                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeStride'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddRouteDialog,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // No Navigator needed!
              // authStateChanges() in main.dart will handle redirect
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Welcome, ${user.email}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestoreService.getAllRoutes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator());
                }

                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No routes found'),
                  );
                }

                final routes = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    final route =
                        routes[index].data()
                            as Map<String, dynamic>;
                    final routeId = routes[index].id;

                    return ListTile(
                      title: Text(
                          route['name'] ?? 'No name'),
                      subtitle: Text(
                          '${route['distance']} km'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await _firestoreService
                              .deleteRoute(routeId);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}