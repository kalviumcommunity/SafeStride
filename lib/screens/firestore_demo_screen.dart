import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDemoScreen extends StatefulWidget {
  const FirestoreDemoScreen({super.key});

  @override
  State<FirestoreDemoScreen> createState() => _FirestoreDemoScreenState();
}

class _FirestoreDemoScreenState extends State<FirestoreDemoScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _addTask() async {
    if (_taskController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': _taskController.text,
        'description': _descriptionController.text,
        'createdAt': DateTime.now().toIso8601String(),
        'completed': false,
      });

      _taskController.clear();
      _descriptionController.clear();

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> _toggleTask(String taskId, bool completed) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .update({'completed': completed});
  }

  Future<void> _deleteTask(String taskId) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Demo - Live Tasks'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddTaskDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Real-time Firestore Demo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This screen demonstrates live data from Cloud Firestore. Add, edit, or delete tasks in Firebase Console to see real-time updates!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Real-time tasks list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
              builder: (context, snapshot) {
                // Handle loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Loading tasks from Firestore...'),
                      ],
                    ),
                  );
                }

                // Handle error state
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 64, color: Colors.red[600]),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading tasks: ${snapshot.error}',
                          style: TextStyle(color: Colors.red[600]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                // Handle empty state
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No tasks found',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Add your first task to get started!',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                // Display tasks
                final tasks = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index].data() as Map<String, dynamic>;
                    final taskId = tasks[index].id;
                    final completed = task['completed'] ?? false;
                    final title = task['title'] ?? 'Untitled Task';
                    final description = task['description'] ?? 'No description';
                    final createdAt = task['createdAt'] ?? '';

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      child: ListTile(
                        leading: Checkbox(
                          value: completed,
                          onChanged: (value) {
                            if (value != null) {
                              _toggleTask(taskId, value);
                            }
                          },
                          activeColor: Colors.blue[600],
                        ),
                        title: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: completed 
                                ? TextDecoration.lineThrough 
                                : TextDecoration.none,
                            color: completed ? Colors.grey : Colors.black,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Created: ${DateTime.parse(createdAt).toString().substring(0, 19)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(taskId),
                        ),
                        isThreeLine: true,
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
