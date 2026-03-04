import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _fcmToken;
  final StreamController<Map<String, dynamic>> _messageStreamController = 
      StreamController<Map<String, dynamic>>.broadcast();

  // Stream to listen to incoming messages
  Stream<Map<String, dynamic>> get messageStream => _messageStreamController.stream;

  // Get current FCM token
  String? get fcmToken => _fcmToken;

  // Initialize FCM
  Future<void> initialize() async {
    try {
      // Request permission for iOS
      await _requestPermission();

      // Get initial message if app was terminated
      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        _handleMessage(initialMessage);
      }

      // Handle messages when app is in foreground
      FirebaseMessaging.onMessage.listen(_handleMessage);

      // Handle messages when app is in background but opened
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

      // Get and save FCM token
      await _getFCMToken();

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((token) {
        _fcmToken = token;
        _saveTokenToPrefs(token);
        debugPrint('FCM Token refreshed: $token');
      });

      debugPrint('FCM Service initialized successfully');
    } catch (e) {
      debugPrint('Error initializing FCM: $e');
    }
  }

  // Request notification permission
  Future<void> _requestPermission() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        debugPrint('User granted provisional permission');
      } else {
        debugPrint('User declined or has not accepted permission');
      }
    }

    if (Platform.isAndroid) {
      // Request notification permission for Android 13+
      if (await Permission.notification.request().isGranted) {
        debugPrint('Android notification permission granted');
      } else {
        debugPrint('Android notification permission denied');
      }
    }
  }

  // Get FCM token
  Future<void> _getFCMToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        _fcmToken = token;
        await _saveTokenToPrefs(token);
        debugPrint('FCM Token: $token');
      }
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
    }
  }

  // Save token to shared preferences
  Future<void> _saveTokenToPrefs(String token) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', token);
      debugPrint('FCM Token saved to preferences');
    } catch (e) {
      debugPrint('Error saving FCM token: $e');
    }
  }

  // Load token from shared preferences
  Future<String?> loadTokenFromPrefs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('fcm_token');
    } catch (e) {
      debugPrint('Error loading FCM token: $e');
      return null;
    }
  }

  // Handle incoming messages
  void _handleMessage(RemoteMessage message) {
    debugPrint('Received message: ${message.messageId}');
    debugPrint('Message data: ${message.data}');
    
    if (message.notification != null) {
      debugPrint('Message notification: ${message.notification}');
    }

    // Add message to stream for UI to listen
    _messageStreamController.add({
      'title': message.notification?.title ?? 'New Notification',
      'body': message.notification?.body ?? 'You have a new message',
      'data': message.data,
      'timestamp': DateTime.now().toIso8601String(),
    });

    // Show local notification (you might want to use a local notification plugin)
    _showLocalNotification(message);
  }

  // Show local notification
  void _showLocalNotification(RemoteMessage message) {
    // This is a basic implementation
    // For production, you might want to use flutter_local_notifications plugin
    debugPrint('Showing local notification: ${message.notification?.title}');
    
    // You can integrate flutter_localNotifications here
    // For now, we'll just log it
  }

  // Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      debugPrint('Unsubscribed from topic: $topic');
    } catch (e) {
      debugPrint('Error unsubscribing from topic: $e');
    }
  }

  // Dispose resources
  void dispose() {
    _messageStreamController.close();
  }
}
