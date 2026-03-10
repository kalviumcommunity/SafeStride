import 'package:flutter/material.dart';

class ScrollableViews extends StatelessWidget {
  const ScrollableViews({super.key});

  // Sample workout data for ListView
  final List<Map<String, dynamic>> workoutSessions = const [
    {
      'title': 'Morning Run',
      'duration': '30 min',
      'calories': 250,
      'difficulty': 'Easy',
      'icon': Icons.directions_run,
      'colorValue': 0xFF2196F3, // Blue
    },
    {
      'title': 'Cycling',
      'duration': '45 min',
      'calories': 400,
      'difficulty': 'Medium',
      'icon': Icons.directions_bike,
      'colorValue': 0xFF4CAF50, // Green
    },
    {
      'title': 'HIIT Training',
      'duration': '20 min',
      'calories': 350,
      'difficulty': 'Hard',
      'icon': Icons.fitness_center,
      'colorValue': 0xFFF44336, // Red
    },
    {
      'title': 'Yoga Session',
      'duration': '60 min',
      'calories': 180,
      'difficulty': 'Easy',
      'icon': Icons.self_improvement,
      'colorValue': 0xFF9C27B0, // Purple
    },
    {
      'title': 'Swimming',
      'duration': '40 min',
      'calories': 450,
      'difficulty': 'Medium',
      'icon': Icons.pool,
      'colorValue': 0xFF00BCD4, // Cyan
    },
    {
      'title': 'Strength Training',
      'duration': '50 min',
      'calories': 300,
      'difficulty': 'Hard',
      'icon': Icons.sports_gymnastics,
      'colorValue': 0xFFFF9800, // Orange
    },
  ];

  // Sample fitness equipment data for GridView
  final List<Map<String, dynamic>> fitnessEquipment = const [
    {'name': 'Treadmill', 'image': '🏃‍♂️', 'available': true},
    {'name': 'Dumbbells', 'image': '🏋️', 'available': true},
    {'name': 'Yoga Mat', 'image': '🧘', 'available': false},
    {'name': 'Bicycle', 'image': '🚴', 'available': true},
    {'name': 'Jump Rope', 'image': '🤸', 'available': true},
    {'name': 'Medicine Ball', 'image': '⚽', 'available': false},
    {'name': 'Resistance Bands', 'image': '🎯', 'available': true},
    {'name': 'Kettlebell', 'image': '🔔', 'available': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeStride - Scrollable Views'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal[400]!, Colors.teal[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fitness Dashboard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Explore workouts and equipment with smooth scrolling',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            /// ---------- HORIZONTAL LISTVIEW SECTION ----------
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '🏃‍♂️ Recent Workout Sessions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),

            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: workoutSessions.length,
                itemBuilder: (context, index) {
                  final workout = workoutSessions[index];
                  final workoutColor = Color(workout['colorValue']);
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: workoutColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: workoutColor.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            workout['icon'],
                            size: 32,
                            color: workoutColor,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            workout['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '⏱ ${workout['duration']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            '🔥 ${workout['calories']} cal',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: workoutColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              workout['difficulty'],
                              style: TextStyle(
                                fontSize: 10,
                                color: workoutColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const Divider(thickness: 2, height: 32),

            /// ---------- VERTICAL LISTVIEW SECTION ----------
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '📋 Workout History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),

            Container(
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal[100 * (index % 9 + 1)],
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text('Workout Session ${index + 1}'),
                    subtitle: Text('Completed ${index + 1} days ago'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening workout ${index + 1} details'),
                          backgroundColor: Colors.teal,
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const Divider(thickness: 2, height: 32),

            /// ---------- GRIDVIEW SECTION ----------
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '🏋️ Available Equipment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: fitnessEquipment.length,
                itemBuilder: (context, index) {
                  final equipment = fitnessEquipment[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: equipment['available']
                          ? Colors.green[50]
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: equipment['available']
                            ? Colors.green[300]!
                            : Colors.grey[300]!,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          equipment['image'],
                          style: const TextStyle(fontSize: 40),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          equipment['name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: equipment['available']
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            equipment['available'] ? 'Available' : 'In Use',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
