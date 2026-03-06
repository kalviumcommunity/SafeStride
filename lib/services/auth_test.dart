import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthTest {
  static Future<void> testAuthSetup() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    
    debugPrint('=== Firebase Auth Test ===');
    debugPrint('Current user: ${auth.currentUser}');
    debugPrint('Auth state changes stream: ${auth.authStateChanges()}');
    
    // Test with a simple email/password
    try {
      debugPrint('Testing sign up with test credentials...');
      
      // This will fail if email/password auth is not enabled
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'test123456',
      );
      
      debugPrint('Sign up successful: ${result.user?.email}');
      
      // Clean up - delete the test user
      await result.user?.delete();
      debugPrint('Test user deleted');
      
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Error: ${e.code} - ${e.message}');
      
      if (e.code == 'email-already-in-use') {
        debugPrint('Test user already exists, trying to sign in...');
        try {
          await auth.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'test123456',
          );
          debugPrint('Sign in successful');
          await auth.currentUser?.delete();
          debugPrint('Test user deleted');
        } catch (signInError) {
          debugPrint('Sign in error: $signInError');
        }
      }
    } catch (e) {
      debugPrint('Unexpected error: $e');
    }
    
    debugPrint('=== End Auth Test ===');
  }
}
