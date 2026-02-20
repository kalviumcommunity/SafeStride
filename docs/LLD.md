# SafeStride - Low-Level Design (LLD)

## 📋 Document Overview

**Project**: SafeStride - Community-Verified Routes for Urban Runners & Cyclists  
**Version**: 1.0.0  
**Date**: February 2026  
**Author**: Team SafeStride  

## 🏗️ Detailed Component Design

### 1. Authentication Service

#### Class: AuthService
```dart
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Properties
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  // Methods
  Future<User?> signUp(String email, String password);
  Future<User?> signIn(String email, String password);
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<void> updateProfile({String? displayName, String? photoURL});
}
```

#### Error Handling
```dart
try {
  User? user = await _auth.signInWithEmailAndPassword(email, password);
  return user;
} on FirebaseAuthException catch (e) {
  debugPrint('Auth error: ${e.code}');
  return null;
}
```

### 2. Firestore Service

#### Class: FirestoreService
```dart
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  // User Management
  Future<void> addUserData(String uid, Map<String, dynamic> data);
  Future<DocumentSnapshot> getUserData(String uid);
  Future<void> updateUserData(String uid, Map<String, dynamic> data);
  
  // Route Management
  Future<void> addRoute(Map<String, dynamic> routeData);
  Stream<QuerySnapshot> getAllRoutes();
  Stream<QuerySnapshot> getRoutesByType(String routeType);
  Future<void> updateRoute(String routeId, Map<String, dynamic> data);
  Future<void> deleteRoute(String routeId);
  
  // Review Management
  Future<void> addReview(String routeId, Map<String, dynamic> reviewData);
  Stream<QuerySnapshot> getRouteReviews(String routeId);
}
```

#### Data Models
```dart
class RouteModel {
  final String? id;
  final String name;
  final String description;
  final String type;
  final double distance;
  final List<GeoPoint> coordinates;
  final double safetyRating;
  final String difficulty;
  final String createdBy;
  final DateTime createdAt;
  final List<String> tags;
  
  RouteModel({
    this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.distance,
    required this.coordinates,
    required this.safetyRating,
    required this.difficulty,
    required this.createdBy,
    required this.createdAt,
    required this.tags,
  });
}

class ReviewModel {
  final String? id;
  final String routeId;
  final String userId;
  final double rating;
  final String comment;
  final double safetyScore;
  final DateTime createdAt;
  final bool helpful;
  
  ReviewModel({
    this.id,
    required this.routeId,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.safetyScore,
    required this.createdAt,
    required this.helpful,
  });
}
```

### 3. UI Components

#### Login Screen Widget Tree
```
Scaffold
├── AppBar (SafeStride)
├── Padding
└── Form
    ├── Column
    │   ├── Text (Welcome)
    │   ├── TextFormField (Email)
    │   ├── TextFormField (Password)
    │   ├── ElevatedButton (Login)
    │   ├── TextButton (Forgot Password)
    │   └── TextButton (Sign Up)
```

#### Home Screen Widget Tree
```
Scaffold
├── AppBar (SafeStride, Actions)
├── Padding
└── Column
    ├── Card (Welcome Message)
    ├── Row (Section Header)
    └── Expanded
        └── StreamBuilder
            └── ListView.builder
                └── Card
                    └── ListTile
                        ├── Leading (Icon)
                        ├── Title (Route Name)
                        ├── Subtitle (Details)
                        └── Trailing (PopupMenu)
```

### 4. State Management

#### Provider Setup
```dart
class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  
  User? get user => _user;
  bool get isAuthenticated => _user != null;
  
  Future<void> signIn(String email, String password) async {
    _user = await _authService.signIn(email, password);
    notifyListeners();
  }
  
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}

class RouteProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<RouteModel> _routes = [];
  
  List<RouteModel> get routes => _routes;
  
  Future<void> loadRoutes() async {
    final snapshot = await _firestoreService.getAllRoutes().first;
    _routes = snapshot.docs
        .map((doc) => RouteModel.fromFirestore(doc))
        .toList();
    notifyListeners();
  }
}
```

## 🔧 Implementation Details

### 1. Firebase Initialization

#### Main Function
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Firebase initialized successfully');
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }
  
  runApp(const SafeStrideApp());
}
```

#### Firebase Options
```dart
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android: return android;
      case TargetPlatform.iOS: return ios;
      default: throw UnsupportedError('Platform not supported');
    }
  }
  
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'your-web-api-key',
    appId: 'your-web-app-id',
    messagingSenderId: 'your-sender-id',
    projectId: 'safestride-65dd6',
  );
  
  // ... other platform configurations
}
```

### 2. Navigation Structure

#### Route Configuration
```dart
class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String routeDetails = '/route-details';
  static const String addRoute = '/add-route';
  static const String profile = '/profile';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
```

### 3. Error Handling Strategy

#### Custom Exception Classes
```dart
class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  
  @override
  String toString() => 'AuthException: $message';
}

class FirestoreException implements Exception {
  final String message;
  FirestoreException(this.message);
  
  @override
  String toString() => 'FirestoreException: $message';
}
```

#### Error Handling Middleware
```dart
class ErrorHandler {
  static void handleError(dynamic error, StackTrace stackTrace) {
    debugPrint('Error occurred: $error');
    debugPrint('Stack trace: $stackTrace');
    
    // Log to crash reporting service
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
    
    // Show user-friendly message
    Get.snackbar(
      'Error',
      'Something went wrong. Please try again.',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
```

### 4. Data Validation

#### Form Validation
```dart
class FormValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  
  static String? validateRouteName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a route name';
    }
    if (value.length < 3) {
      return 'Route name must be at least 3 characters';
    }
    return null;
  }
}
```

### 5. Performance Optimization

#### Image Caching
```dart
class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });
  
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      memCacheWidth: width?.toInt(),
      memCacheHeight: height?.toInt(),
    );
  }
}
```

#### Lazy Loading
```dart
class LazyListView extends StatefulWidget {
  final Future<List<dynamic>> Function() fetchData;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  
  const LazyListView({
    super.key,
    required this.fetchData,
    required this.itemBuilder,
  });
  
  @override
  State<LazyListView> createState() => _LazyListViewState();
}

class _LazyListViewState extends State<LazyListView> {
  final ScrollController _scrollController = ScrollController();
  List<dynamic> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  
  @override
  void initState() {
    super.initState();
    _loadMoreItems();
    _scrollController.addListener(_scrollListener);
  }
  
  void _scrollListener() {
    if (_scrollController.position.pixels == 
        _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }
  
  Future<void> _loadMoreItems() async {
    if (_isLoading || !_hasMore) return;
    
    setState(() => _isLoading = true);
    
    try {
      final newItems = await widget.fetchData();
      setState(() {
        _items.addAll(newItems);
        _hasMore = newItems.isNotEmpty;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }
}
```

## 🧪 Testing Strategy

### Unit Tests
```dart
void main() {
  group('AuthService Tests', () {
    late AuthService authService;
    
    setUp(() {
      authService = AuthService();
    });
    
    test('should sign in user with valid credentials', () async {
      // Test implementation
    });
    
    test('should throw error with invalid credentials', () async {
      // Test implementation
    });
  });
}
```

### Widget Tests
```dart
void main() {
  testWidgets('Login screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    
    expect(find.text('Welcome to SafeStride'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
```

### Integration Tests
```dart
void main() {
  integrationTest('Complete login flow', () async {
    // Test complete user journey
  });
}
```

## 📱 Platform-Specific Implementation

### Android Configuration
```gradle
// android/app/build.gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.example.safestride"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
}

dependencies {
    implementation 'com.google.firebase:firebase-bom:32.7.0'
    implementation 'com.google.firebase:firebase-analytics'
    implementation 'com.google.firebase:firebase-auth'
    implementation 'com.google.firebase:firebase-firestore'
}

apply plugin: 'com.google.gms.google-services'
```

### iOS Configuration
```xml
<!-- ios/Runner/Info.plist -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to show nearby routes</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs location access to track your runs</string>
```

## 🔒 Security Implementation

### Firestore Security Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own profile
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Anyone can read routes, only authenticated users can write
    match /routes/{routeId} {
      allow read: if true;
      allow write: if request.auth != null;
      allow delete: if request.auth != null && 
        resource.data.createdBy == request.auth.uid;
    }
    
    // Reviews can be read by anyone, written by authenticated users
    match /reviews/{reviewId} {
      allow read: if true;
      allow write: if request.auth != null;
      allow update, delete: if request.auth != null && 
        resource.data.userId == request.auth.uid;
    }
  }
}
```

---

**Document Status**: ✅ Complete  
**Implementation Status**: 🔄 In Progress  
**Review Date**: Weekly during sprint
