import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  // ADD RECORD
  Future<void> _addRecord() async {
    String title = titleController.text.trim();
    String content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fields cannot be empty")));
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('notes').add({
        'title': title,
        'content': content,
        'createdAt': Timestamp.now(),
      });

      titleController.clear();
      contentController.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  // UPDATE RECORD
  Future<void> _updateRecord(String docId, String newTitle) async {
    try {
      await FirebaseFirestore.instance.collection('notes').doc(docId).update({
        'title': newTitle,
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Update failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firestore Notes")),

      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),

          TextField(
            controller: contentController,
            decoration: const InputDecoration(labelText: "Content"),
          ),

          ElevatedButton(onPressed: _addRecord, child: const Text("Add")),

          const Divider(),

          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('notes')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),

              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();

                var docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,

                  itemBuilder: (context, index) {
                    var doc = docs[index];

                    return ListTile(
                      title: Text(doc['title']),
                      subtitle: Text(doc['content']),

                      trailing: IconButton(
                        icon: const Icon(Icons.edit),

                        onPressed: () {
                          _updateRecord(doc.id, "Updated Title");
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
