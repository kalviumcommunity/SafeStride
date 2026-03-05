import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskQueryScreen extends StatelessWidget {
  const TaskQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final query = FirebaseFirestore.instance
        .collection('tasks')
        // FILTER → only incomplete tasks
        .where('isCompleted', isEqualTo: false)
        // SORT → priority ascending
        .orderBy('priority')
        // LIMIT → show only first 20
        .limit(20);

    return Scaffold(
      appBar: AppBar(title: const Text("Filtered Tasks")),

      body: StreamBuilder<QuerySnapshot>(
        stream: query.snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No tasks found"));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,

            itemBuilder: (context, index) {
              final task = docs[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(task['title']),

                  subtitle: Text(
                    "Priority: ${task['priority']} | Completed: ${task['isCompleted']}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
