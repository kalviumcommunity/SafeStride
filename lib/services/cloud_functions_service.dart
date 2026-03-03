import 'dart:developer' as developer;
import 'package:cloud_functions/cloud_functions.dart';

class CloudFunctionsService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  // =========================
  // CALLABLE FUNCTIONS
  // =========================

  /// Welcome message function
  /// Returns a personalized welcome message
  Future<Map<String, dynamic>> sayHello({String? name}) async {
    try {
      final callable = _functions.httpsCallable('sayHello');
      final result = await callable.call({'name': name});
      
      developer.log('sayHello result: ${result.data}');
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      developer.log('Error calling sayHello: $e');
      rethrow;
    }
  }

  /// Route validation function
  /// Validates route data against SafeStride requirements
  Future<Map<String, dynamic>> validateRoute(Map<String, dynamic> routeData) async {
    try {
      final callable = _functions.httpsCallable('validateRoute');
      final result = await callable.call(routeData);
      
      developer.log('validateRoute result: ${result.data}');
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      developer.log('Error calling validateRoute: $e');
      rethrow;
    }
  }

  /// Safety score calculation function
  /// Calculates safety score based on various factors
  Future<Map<String, dynamic>> calculateSafetyScore({
    required String routeType,
    required double distance,
    required String timeOfDay,
    required String weatherConditions,
  }) async {
    try {
      final callable = _functions.httpsCallable('calculateSafetyScore');
      final result = await callable.call({
        'routeType': routeType,
        'distance': distance,
        'timeOfDay': timeOfDay,
        'weatherConditions': weatherConditions,
      });
      
      developer.log('calculateSafetyScore result: ${result.data}');
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      developer.log('Error calling calculateSafetyScore: $e');
      rethrow;
    }
  }

  // =========================
  // HTTP FUNCTIONS (Alternative approach)
  // =========================

  /// Health check function
  /// Checks if Cloud Functions are working
  Future<Map<String, dynamic>> healthCheck() async {
    try {
      final callable = _functions.httpsCallable('healthCheck');
      final result = await callable.call();
      
      developer.log('healthCheck result: ${result.data}');
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      developer.log('Error calling healthCheck: $e');
      rethrow;
    }
  }

  /// Route statistics function
  /// Returns aggregated statistics about routes
  Future<Map<String, dynamic>> getRouteStats() async {
    try {
      final callable = _functions.httpsCallable('getRouteStats');
      final result = await callable.call();
      
      developer.log('getRouteStats result: ${result.data}');
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      developer.log('Error calling getRouteStats: $e');
      rethrow;
    }
  }

  // =========================
  // UTILITY METHODS
  // =========================

  /// Test all callable functions
  /// Useful for testing and debugging
  Future<Map<String, dynamic>> testAllFunctions() async {
    final results = <String, dynamic>{};
    
    try {
      // Test sayHello
      results['sayHello'] = await sayHello(name: 'SafeStride Test User');
      
      // Test route validation
      final testRoute = {
        'name': 'Test Route',
        'distance': 5.2,
        'type': 'running',
        'safetyRating': 4.5,
      };
      results['validateRoute'] = await validateRoute(testRoute);
      
      // Test safety score calculation
      results['calculateSafetyScore'] = await calculateSafetyScore(
        routeType: 'running',
        distance: 5.2,
        timeOfDay: 'morning',
        weatherConditions: 'clear',
      );
      
      // Test health check
      results['healthCheck'] = await healthCheck();
      
      developer.log('All functions test completed: $results');
      return results;
    } catch (e) {
      developer.log('Error testing functions: $e');
      results['error'] = e.toString();
      return results;
    }
  }

  /// Get function logs (simulated - in production you'd use proper logging)
  /// This is a placeholder for getting function execution logs
  Future<List<String>> getFunctionLogs() async {
    // In a real implementation, you might use Firebase Admin SDK
    // or integrate with a logging service
    return [
      '[${DateTime.now().toIso8601String()}] Cloud Functions Service initialized',
      '[${DateTime.now().toIso8601String()}] Ready to execute callable functions',
      '[${DateTime.now().toIso8601String()}] Event-based functions are listening',
    ];
  }

  /// Check if functions are deployed and accessible
  Future<bool> checkFunctionsAvailability() async {
    try {
      final result = await healthCheck();
      return result['status'] == 'healthy';
    } catch (e) {
      developer.log('Functions not available: $e');
      return false;
    }
  }

  /// Get function execution metrics (simulated)
  Future<Map<String, dynamic>> getFunctionMetrics() async {
    // In a real implementation, you'd get actual metrics from Firebase
    return {
      'totalCalls': 0,
      'successfulCalls': 0,
      'failedCalls': 0,
      'averageExecutionTime': 0.0,
      'lastUpdated': DateTime.now().toIso8601String(),
    };
  }
}
