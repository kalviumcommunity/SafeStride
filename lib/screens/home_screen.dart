import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'firestore_demo_screen.dart';
import 'realtime_sync_demo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  final TextEditingController _routeNameController =
      TextEditingController();
  final TextEditingController _routeDistanceController =
      TextEditingController();

  Future<void> _addSampleRoute() async {
    await _firestoreService.addRoute({
      'name': 'Central Park Loop',
      'type': 'running',
      'distance': 5.2,
      'safetyRating': 4.5,
      'difficulty': 'medium',
      'description': 'Beautiful loop around Central Park with scenic views',
      'createdAt': DateTime.now().toIso8601String(),
      'createdBy': FirebaseAuth.instance.currentUser?.uid,
    });

    await _firestoreService.addRoute({
      'name': 'Brooklyn Bridge Route',
      'type': 'cycling',
      'distance': 8.7,
      'safetyRating': 4.2,
      'difficulty': 'hard',
      'description': 'Challenging route with iconic bridge views',
      'createdAt': DateTime.now().toIso8601String(),
      'createdBy': FirebaseAuth.instance.currentUser?.uid,
    });
  }

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
              final name = _routeNameController.text.trim();
              final distance =
                  double.tryParse(_routeDistanceController.text);

              if (name.isNotEmpty && distance != null) {
                await _firestoreService.addRoute({
                  'name': name,
                  'distance': distance,
                });

                _routeNameController.clear();
                _routeDistanceController.clear();

                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(
      String routeId, Map<String, dynamic> route) async {
    _routeNameController.text = route['name'];
    _routeDistanceController.text =
        route['distance'].toString();

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Route"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _routeNameController),
            const SizedBox(height: 10),
            TextField(
              controller: _routeDistanceController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _firestoreService.updateRoute(routeId, {
                'name': _routeNameController.text,
                'distance': double.tryParse(
                        _routeDistanceController.text) ??
                    0,
              });

              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
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
            icon: const Icon(Icons.map),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Map feature coming in next update!'),
                  backgroundColor: Colors.blue,
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MapScreen(),
                ),
              );
            },
            tooltip: 'Map View',
          ),
          IconButton(
            icon: const Icon(Icons.storage),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FirestoreDemoScreen(),
                ),
              );
            },
            tooltip: 'Firestore Demo',
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RealtimeSyncDemo(),
                ),
              );
            },
            tooltip: 'Real-Time Sync Demo',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddRouteDialog,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Welcome, ${user.email}",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
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
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_run,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No routes available',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Add your first route to get started!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${route['distance']?.toString() ?? '0'} km • ${route['difficulty'] ?? 'Unknown'}',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await _firestoreService.deleteRoute(routeId);
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestoreService.getUserRoutes(),
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

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(
                          route['name'] ?? 'No name',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            Text('${route['distance']} km'),
                        onTap: () =>
                            _showEditDialog(routeId, route),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete,
                              color: Colors.red),
                          onPressed: () async {
                            await _firestoreService
                                .deleteRoute(routeId);
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
    );
  }
}
