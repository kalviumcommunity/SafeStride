import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _routeDistanceController = TextEditingController();

  @override
  void dispose() {
    _routeNameController.dispose();
    _routeDistanceController.dispose();
    super.dispose();
  }

  Future<void> _addSampleRoute() async {
    await _firestoreService.addRoute({
      'name': 'Central Park Loop',
      'type': 'running',
      'distance': 5.2,
      'safetyRating': 4.5,
      'difficulty': 'medium',
      'description': 'Beautiful loop around Central Park with scenic views',
      'createdAt': DateTime.now().toIso8601String(),
      'createdBy': _authService.currentUser?.uid,
    });

    await _firestoreService.addRoute({
      'name': 'Brooklyn Bridge Route',
      'type': 'cycling',
      'distance': 8.7,
      'safetyRating': 4.2,
      'difficulty': 'hard',
      'description': 'Challenging route with iconic bridge views',
      'createdAt': DateTime.now().toIso8601String(),
      'createdBy': _authService.currentUser?.uid,
    });
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
                  'type': 'running',
                  'distance': double.parse(_routeDistanceController.text),
                  'safetyRating': 4.0,
                  'difficulty': 'medium',
                  'description': 'User added route',
                  'createdAt': DateTime.now().toIso8601String(),
                  'createdBy': _authService.currentUser?.uid,
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
    final user = _authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeStride'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddRouteDialog,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green[600],
                      child: Text(
                        user?.email?.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            user?.email ?? 'User',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Routes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                TextButton.icon(
                  onPressed: _addSampleRoute,
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Add Sample'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Routes List
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestoreService.getAllRoutes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red[600]),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_run,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No routes available',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add your first route to get started!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final routes = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: routes.length,
                    itemBuilder: (context, index) {
                      final route = routes[index].data() as Map<String, dynamic>;
                      final routeId = routes[index].id;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: route['type'] == 'running'
                                ? Colors.orange[100]
                                : Colors.blue[100],
                            child: Icon(
                              route['type'] == 'running'
                                  ? Icons.directions_run
                                  : Icons.directions_bike,
                              color: route['type'] == 'running'
                                  ? Colors.orange[600]
                                  : Colors.blue[600],
                            ),
                          ),
                          title: Text(
                            route['name'] ?? 'Unknown Route',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${route['distance']?.toStringAsFixed(1) ?? '0.0'} km • ${route['difficulty'] ?? 'medium'} difficulty',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber[600],
                                  ),
                                  Text(
                                    ' ${route['safetyRating']?.toStringAsFixed(1) ?? '4.0'} safety rating',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                            ],
                            onSelected: (value) async {
                              if (value == 'delete') {
                                await _firestoreService.deleteRoute(routeId);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
