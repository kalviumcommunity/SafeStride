import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  // =========================
  // USER DATA CRUD
  // =========================

  Future<void> addUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(uid).set(data);
    } catch (e) {
      debugPrint('Error adding user data: $e');
    }
  }

  Future<DocumentSnapshot> getUserData(String uid) async {
    try {
      return await _db.collection('users').doc(uid).get();
    } catch (e) {
      debugPrint('Error getting user data: $e');
      rethrow;
    }
  }

  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(uid).update(data);
    } catch (e) {
      debugPrint('Error updating user data: $e');
    }
  }

  Future<void> deleteUserData(String uid) async {
    try {
      await _db.collection('users').doc(uid).delete();
    } catch (e) {
      debugPrint('Error deleting user data: $e');
    }
  }

  // =========================
  // ROUTE CRUD (USER-SPECIFIC)
  // =========================

  Future<void> addRoute(Map<String, dynamic> routeData) async {
    try {
      if (_uid == null) throw Exception("User not logged in");

      await _db.collection('routes').add({
        ...routeData,
        'createdBy': _uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error adding route: $e');
    }
  }

  // Get ONLY current user's routes
  Stream<QuerySnapshot> getUserRoutes() {
    if (_uid == null) {
      return const Stream.empty();
    }

    return _db
        .collection('routes')
        .where('createdBy', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
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
  Future<void> updateRoute(
      String routeId, Map<String, dynamic> data) async {
    try {
      await _db.collection('routes').doc(routeId).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error updating route: $e');
    }
  }

  Future<void> deleteRoute(String routeId) async {
    try {
      await _db.collection('routes').doc(routeId).delete();
    } catch (e) {
      debugPrint('Error deleting route: $e');
    }
  }

  // =========================
  // REVIEWS
  // =========================

  Future<void> addReview(
      String routeId, Map<String, dynamic> reviewData) async {
    try {
      await _db
          .collection('routes')
          .doc(routeId)
          .collection('reviews')
          .add(reviewData);
    } catch (e) {
      debugPrint('Error adding review: $e');
    }
  }

  Stream<QuerySnapshot> getRouteReviews(String routeId) {
    return _db
        .collection('routes')
        .doc(routeId)
        .collection('reviews')
        .snapshots();
  }

  // =========================
  // FAVORITES
  // =========================

  Stream<QuerySnapshot> getUserFavoriteRoutes() {
    if (_uid == null) {
      return const Stream.empty();
    }

    return _db
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .snapshots();
  }

  Future<void> addToFavorites(String routeId) async {
    try {
      if (_uid == null) throw Exception("User not logged in");

      await _db
          .collection('users')
          .doc(_uid)
          .collection('favorites')
          .doc(routeId)
          .set({'addedAt': FieldValue.serverTimestamp()});
    } catch (e) {
      debugPrint('Error adding to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(String routeId) async {
    try {
      if (_uid == null) throw Exception("User not logged in");

      await _db
          .collection('users')
          .doc(_uid)
          .collection('favorites')
          .doc(routeId)
          .delete();
    } catch (e) {
      debugPrint('Error removing from favorites: $e');
    }
  }
}