import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add user data to Firestore
  Future<void> addUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(uid).set(data);
    } catch (e) {
      debugPrint('Error adding user data: $e');
    }
  }

  // Get user data
  Future<DocumentSnapshot> getUserData(String uid) async {
    try {
      return await _db.collection('users').doc(uid).get();
    } catch (e) {
      debugPrint('Error getting user data: $e');
      rethrow;
    }
  }

  // Update user data
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(uid).update(data);
    } catch (e) {
      debugPrint('Error updating user data: $e');
    }
  }

  // Delete user data
  Future<void> deleteUserData(String uid) async {
    try {
      await _db.collection('users').doc(uid).delete();
    } catch (e) {
      debugPrint('Error deleting user data: $e');
    }
  }

  // Add a new route
  Future<void> addRoute(Map<String, dynamic> routeData) async {
    try {
      await _db.collection('routes').add(routeData);
    } catch (e) {
      debugPrint('Error adding route: $e');
    }
  }

  // Get all routes
  Stream<QuerySnapshot> getAllRoutes() {
    return _db.collection('routes').snapshots();
  }

  // Get routes by type (running/cycling)
  Stream<QuerySnapshot> getRoutesByType(String routeType) {
    return _db
        .collection('routes')
        .where('type', isEqualTo: routeType)
        .snapshots();
  }

  // Get route by ID
  Future<DocumentSnapshot> getRouteById(String routeId) async {
    try {
      return await _db.collection('routes').doc(routeId).get();
    } catch (e) {
      debugPrint('Error getting route: $e');
      rethrow;
    }
  }

  // Get route by ID with real-time updates
  Stream<DocumentSnapshot> getRouteByIdStream(String routeId) {
    return _db.collection('routes').doc(routeId).snapshots();
  }

  // Get user data with real-time updates
  Stream<DocumentSnapshot> getUserDataStream(String uid) {
    return _db.collection('users').doc(uid).snapshots();
  }

  // Update route
  Future<void> updateRoute(String routeId, Map<String, dynamic> data) async {
    try {
      await _db.collection('routes').doc(routeId).update(data);
    } catch (e) {
      debugPrint('Error updating route: $e');
    }
  }

  // Delete route
  Future<void> deleteRoute(String routeId) async {
    try {
      await _db.collection('routes').doc(routeId).delete();
    } catch (e) {
      debugPrint('Error deleting route: $e');
    }
  }

  // Add a review for a route
  Future<void> addReview(String routeId, Map<String, dynamic> reviewData) async {
    try {
      await _db.collection('routes').doc(routeId).collection('reviews').add(reviewData);
    } catch (e) {
      debugPrint('Error adding review: $e');
    }
  }

  // Get reviews for a route
  Stream<QuerySnapshot> getRouteReviews(String routeId) {
    return _db.collection('routes').doc(routeId).collection('reviews').snapshots();
  }

  // Get user's favorite routes
  Stream<QuerySnapshot> getUserFavoriteRoutes(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots();
  }

  // Add route to favorites
  Future<void> addToFavorites(String userId, String routeId) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(routeId)
          .set({'addedAt': DateTime.now()});
    } catch (e) {
      debugPrint('Error adding to favorites: $e');
    }
  }

  // Remove route from favorites
  Future<void> removeFromFavorites(String userId, String routeId) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(routeId)
          .delete();
    } catch (e) {
      debugPrint('Error removing from favorites: $e');
    }
  }
}
