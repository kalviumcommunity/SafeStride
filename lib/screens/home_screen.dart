import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../widgets/info_card.dart';
import 'details_screen.dart';
import 'scrollable_views.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeStride'),
        actions: [
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
          
          // Custom InfoCard Widgets
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                InfoCard(
                  title: 'Profile',
                  subtitle: 'View your account details and preferences',
                  icon: Icons.person,
                  iconColor: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailsScreen(),
                      ),
                    );
                  },
                ),
                InfoCard(
                  title: 'Settings',
                  subtitle: 'Manage app preferences and notifications',
                  icon: Icons.settings,
                  iconColor: Colors.green,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings feature coming soon!')),
                    );
                  },
                ),
                InfoCard(
                  title: 'Statistics',
                  subtitle: 'View your running and cycling statistics',
                  icon: Icons.analytics,
                  iconColor: Colors.orange,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Statistics feature coming soon!')),
                    );
                  },
                ),
                InfoCard(
                  title: 'Scrollable Views',
                  subtitle: 'Explore ListView and GridView examples',
                  icon: Icons.view_list,
                  iconColor: Colors.purple,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScrollableViews(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Routes section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
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
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Add route feature coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Add Sample'),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const Center(
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
                      'Routes feature coming soon!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
