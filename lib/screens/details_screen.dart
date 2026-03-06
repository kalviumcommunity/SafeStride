import 'package:flutter/material.dart';
import '../widgets/info_card.dart';
import '../widgets/like_button.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Account Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              
              // Reusing InfoCard with different data
              InfoCard(
                title: 'Account Info',
                subtitle: 'User details and subscription status',
                icon: Icons.info,
                iconColor: Colors.blue,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening account details...')),
                  );
                },
              ),
              
              InfoCard(
                title: 'Subscription',
                subtitle: 'Premium features and billing',
                icon: Icons.card_membership,
                iconColor: Colors.purple,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening subscription details...')),
                  );
                },
              ),
              
              InfoCard(
                title: 'Privacy Settings',
                subtitle: 'Control your data and privacy',
                icon: Icons.lock,
                iconColor: Colors.red,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening privacy settings...')),
                  );
                },
              ),
              
              const SizedBox(height: 30),
              
              const Text(
                'Route Preferences',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              
              InfoCard(
                title: 'Favorite Routes',
                subtitle: 'Your saved and bookmarked routes',
                icon: Icons.favorite,
                iconColor: Colors.red,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening favorite routes...')),
                  );
                },
              ),
              
              InfoCard(
                title: 'Route History',
                subtitle: 'View your completed routes',
                icon: Icons.history,
                iconColor: Colors.orange,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening route history...')),
                  );
                },
              ),
              
              const SizedBox(height: 30),
              
              const Text(
                'Interactive Features',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),
              
              // Demo of LikeButton widget
              Card(
                margin: const EdgeInsets.all(12),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Like Button Demo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text('Like this route: '),
                          LikeButton(
                            initialLiked: false,
                            showCount: true,
                            initialCount: 42,
                            likedColor: Colors.red,
                            unlikedColor: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Another example: '),
                          LikeButton(
                            initialLiked: true,
                            showCount: true,
                            initialCount: 128,
                            likedColor: Colors.pink,
                            unlikedColor: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
