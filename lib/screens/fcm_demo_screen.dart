import 'package:flutter/material.dart';
import '../services/fcm_service.dart';

class FCMDemoScreen extends StatefulWidget {
  const FCMDemoScreen({super.key});

  @override
  State<FCMDemoScreen> createState() => _FCMDemoScreenState();
}

class _FCMDemoScreenState extends State<FCMDemoScreen> {
  final FCMService _fcmService = FCMService();
  String? _fcmToken;
  List<Map<String, dynamic>> _messages = [];
  final TextEditingController _topicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeFCM();
  }

  Future<void> _initializeFCM() async {
    try {
      await _fcmService.initialize();
      
      // Load saved token
      String? savedToken = await _fcmService.loadTokenFromPrefs();
      if (savedToken != null) {
        setState(() {
          _fcmToken = savedToken;
        });
      }

      // Listen to incoming messages
      _fcmService.messageStream.listen((message) {
        setState(() {
          _messages.insert(0, message);
          if (_messages.length > 10) {
            _messages.removeLast();
          }
        });
      });

      // Get current token
      String? currentToken = _fcmService.fcmToken;
      if (currentToken != null) {
        setState(() {
          _fcmToken = currentToken;
        });
      }
    } catch (e) {
      _showErrorSnackBar('Error initializing FCM: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _subscribeToTopic() async {
    if (_topicController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter a topic name');
      return;
    }

    try {
      await _fcmService.subscribeToTopic(_topicController.text.trim());
      _showSuccessSnackBar('Subscribed to topic: ${_topicController.text.trim()}');
      _topicController.clear();
    } catch (e) {
      _showErrorSnackBar('Error subscribing to topic: $e');
    }
  }

  Future<void> _unsubscribeFromTopic() async {
    if (_topicController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter a topic name');
      return;
    }

    try {
      await _fcmService.unsubscribeFromTopic(_topicController.text.trim());
      _showSuccessSnackBar('Unsubscribed from topic: ${_topicController.text.trim()}');
      _topicController.clear();
    } catch (e) {
      _showErrorSnackBar('Error unsubscribing from topic: $e');
    }
  }

  void _copyTokenToClipboard() {
    if (_fcmToken != null) {
      // Here you would use flutter/services to copy to clipboard
      // For now, just show a snackbar
      _showSuccessSnackBar('Token copied to clipboard (simulated)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FCM Demo'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FCM Token Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FCM Token',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _fcmToken != null
                          ? Text(
                              _fcmToken!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                              ),
                            )
                          : const Text('Loading...'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _copyTokenToClipboard,
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy Token'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Topic Subscription Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Topic Subscription',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _topicController,
                      decoration: const InputDecoration(
                        labelText: 'Topic Name',
                        hintText: 'e.g., safestride_updates',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _subscribeToTopic,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Subscribe'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _unsubscribeFromTopic,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Unsubscribe'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Messages Section
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Received Messages',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: _messages.isEmpty
                            ? const Center(
                                child: Text(
                                  'No messages received yet.\nSend a test notification from Firebase Console!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: _messages.length,
                                itemBuilder: (context, index) {
                                  final message = _messages[index];
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      leading: const Icon(Icons.notifications, color: Colors.orange),
                                      title: Text(
                                        message['title'] ?? 'No Title',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        message['body'] ?? 'No Body',
                                        style: TextStyle(color: Colors.grey[600]),
                                      ),
                                      trailing: Text(
                                        _formatTimestamp(message['timestamp']),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(String? timestamp) {
    if (timestamp == null) return '';
    try {
      DateTime dateTime = DateTime.parse(timestamp);
      return '${dateTime.hour.toString().padLeft(2, '0')}:'
          '${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }

  @override
  void dispose() {
    _topicController.dispose();
    _fcmService.dispose();
    super.dispose();
  }
}
