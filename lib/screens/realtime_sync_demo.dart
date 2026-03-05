import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RealtimeSyncDemo extends StatefulWidget {
  const RealtimeSyncDemo({super.key});

  @override
  State<RealtimeSyncDemo> createState() => _RealtimeSyncDemoState();
}

class _RealtimeSyncDemoState extends State<RealtimeSyncDemo> {
  final TextEditingController _postTitleController = TextEditingController();
  final TextEditingController _postContentController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  
  String _selectedUserId = '';

  @override
  void dispose() {
    _postTitleController.dispose();
    _postContentController.dispose();
    _userNameController.dispose();
    _userEmailController.dispose();
    super.dispose();
  }

  Future<void> _addPost() async {
    if (_postTitleController.text.isNotEmpty && _postContentController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('posts').add({
        'title': _postTitleController.text,
        'content': _postContentController.text,
        'author': FirebaseAuth.instance.currentUser?.email ?? 'Anonymous',
        'createdAt': DateTime.now().toIso8601String(),
        'likes': 0,
        'comments': 0,
      });

      _postTitleController.clear();
      _postContentController.clear();

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> _updateUser() async {
    if (_selectedUserId.isNotEmpty && _userNameController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('users').doc(_selectedUserId).update({
        'name': _userNameController.text,
        'email': _userEmailController.text,
        'lastUpdated': DateTime.now().toIso8601String(),
      });

      _userNameController.clear();
      _userEmailController.clear();

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _showAddPostDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _postTitleController,
              decoration: const InputDecoration(
                labelText: 'Post Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _postContentController,
              decoration: const InputDecoration(
                labelText: 'Post Content',
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
            onPressed: _addPost,
            child: const Text('Add Post'),
          ),
        ],
      ),
    );
  }

  void _showUpdateUserDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update User Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: 'User Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _userEmailController,
              decoration: const InputDecoration(
                labelText: 'User Email',
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
            onPressed: _updateUser,
            child: const Text('Update User'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Sync Demo'),
        backgroundColor: Colors.purple[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddPostDialog,
            tooltip: 'Add Post',
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with instructions
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.purple[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Real-Time Synchronization Demo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This demo shows real-time updates for both collections and individual documents. Add posts or update user profiles in Firebase Console to see instant updates!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.purple[600],
                  ),
                ),
              ],
            ),
          ),

          // User Profile Section (Document-level listener)
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User Profile (Document Listener)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _selectedUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
                        _showUpdateUserDialog();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (FirebaseAuth.instance.currentUser != null)
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const Text('No user profile found');
                      }

                      final userData = snapshot.data!.data() as Map<String, dynamic>;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: ${userData['name'] ?? 'Not set'}'),
                          Text('Email: ${userData['email'] ?? 'Not set'}'),
                          Text('Last Updated: ${userData['lastUpdated'] ?? 'Never'}'),
                        ],
                      );
                    },
                  )
                else
                  const Text('Please log in to see user profile'),
              ],
            ),
          ),

          // Posts Section (Collection listener)
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Live Posts Feed (Collection Listener)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .orderBy('createdAt', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        // Handle loading state
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text('Loading posts...'),
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
                                Icon(Icons.error, size: 64, color: Colors.red),
                                const SizedBox(height: 16),
                                Text(
                                  'Error loading posts: ${snapshot.error}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red),
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
                                Icon(Icons.article_outlined, size: 64, color: Colors.grey),
                                SizedBox(height: 16),
                                Text(
                                  'No posts yet',
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Add your first post to get started!',
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }

                        // Display posts
                        final posts = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index].data() as Map<String, dynamic>;
                            final createdAt = post['createdAt'] ?? '';

                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              elevation: 2,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.purple[100],
                                  child: Icon(Icons.article, color: Colors.purple[600]),
                                ),
                                title: Text(
                                  post['title'] ?? 'Untitled Post',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post['content'] ?? 'No content',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          'By: ${post['author'] ?? 'Anonymous'}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          DateTime.parse(createdAt)
                                              .toString()
                                              .substring(0, 19),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.favorite, size: 16, color: Colors.red),
                                        Text('${post['likes'] ?? 0}'),
                                      ],
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.comment, size: 16, color: Colors.blue),
                                        Text('${post['comments'] ?? 0}'),
                                      ],
                                    ),
                                  ],
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
            ),
          ),
        ],
      ),
    );
  }
}
