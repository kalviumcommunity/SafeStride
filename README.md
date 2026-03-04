# SafeStride – Community-Verified Routes for Urban Runners & Cyclists

A cross-platform mobile application that helps runners and cyclists discover safe, community-validated routes using real user reviews, ratings, and shared experiences.

## 🎯 Project Overview

SafeStride addresses the common problem faced by urban runners and cyclists who lack access to safe, well-reviewed routes. Our platform enables users to discover trusted paths validated by the community, making informed decisions before choosing their routes.

## 🚀 Core Features (MVP)

### User Features
- **User Authentication**: Registration and login using Firebase Authentication
- **Route Discovery**: Browse nearby running and cycling routes
- **Route Details**: View comprehensive information including:
  - Distance
  - Route type (running/cycling)
  - Safety rating
  - User reviews
- **Community Contribution**: Add new routes with basic details
- **Reviews & Ratings**: Rate and review existing routes

### System Features
- **Real-time Updates**: Live updates of reviews and ratings
- **Community Safety Score**: Aggregated safety ratings from the community
- **Data Validation**: Basic validation and moderation system

## 🛠 Technology Stack

### Frontend (Mobile App)
- **Flutter** - Cross-platform mobile development
- **Dart** - Programming language
- **Flutter Widgets** - Responsive UI components

### Backend & Services
- **Firebase Authentication** - User authentication
- **Firebase Firestore** - Real-time database
- **Firebase Cloud Storage** - Optional image storage

### Design
- **Figma** - UI/UX design
- **Design Thinking** - User-centric approach

## 👥 Team Roles

### Member 1 – Flutter & UI Developer
- Implement Flutter UI screens
- Integrate Figma designs into Flutter
- Handle navigation and responsiveness

### Member 2 – Firebase & Backend Developer
- Set up Firebase project
- Implement authentication
- Manage Firestore database (routes, users, reviews)
- Real-time data integration

### Member 3 – Project Manager & QA
- Sprint planning and task tracking
- Documentation (HLD, LLD)
- Testing and validation
- Assist in frontend/backend when needed

## 📅 4-Week Sprint Plan

### Week 1 – Planning & Design
- [x] Understand problem and define MVP
- [x] Design wireframes in Figma
- [x] Create High-Level Design (HLD)
- [x] Set up Flutter and Firebase project

**Deliverables:**
- [x] Wireframes
- [x] HLD document
- [x] Project setup

### Week 2 – Core Development
- [x] Implement user authentication
- [x] Create basic Flutter screens
- [x] Firestore schema design
- [x] Add and fetch route data

**Deliverables:**
- [x] Login & signup working
- [x] Route listing screen
- [x] Firestore integration

### Week 3 – Community Features
- [x] Ratings and reviews feature
- [x] Safety score logic
- [x] Route detail screen
- [x] UI improvements and validations

**Deliverables:**
- [x] Reviews & ratings functional
- [x] Route details displayed correctly
- [x] Stable app flow

### Week 4 – Testing & Finalization
- [x] Create Low-Level Design (LLD)
- [x] End-to-end testing
- [x] Bug fixing
- [x] Final demo preparation and documentation

**Deliverables:**
- [x] LLD document
- [x] Tested MVP
- [x] Final presentation/demo

## 📊 Success Criteria

- [x] Users can log in and register successfully
- [x] At least 8–10 routes added to app
- [x] Each route supports reviews and ratings
- [x] Safety score updates in real time
- [x] App runs smoothly on web browser
- [x] Project meets Sprint objectives

## 🎓 Curriculum Alignment

This project aligns with the simulated work curriculum through:
- Flutter & Dart fundamentals
- Firebase real-time data integration
- Design thinking principles
- High-Level and Low-Level Design documentation
- Collaborative sprint-based development

## � Common Setup Issues

| Issue | Cause | Solution |
|-------|--------|----------|
| flutterfire not recognized | CLI not added to PATH | Add ~/.pub-cache/bin to PATH |
| Firebase not initialized | Missing await Firebase.initializeApp() | Add initialization in main() |
| Wrong Firebase project selected | Incorrect project chosen | Re-run flutterfire configure |
| Build fails | Gradle plugin missing | Add apply plugin: 'com.google.gms.google-services' in android/app/build.gradle |

## 🔥 Firebase Authentication Setup

### 1. Enable Email/Password Authentication in Firebase Console
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: "safestride-65dd6"
3. Navigate to **Authentication** → **Sign-in method**
4. Click **Email/Password** → **Enable**
5. Go to **Settings** → **Authorized domains**
6. Add your app domain (if applicable)

### 2. Firebase Authentication Implementation

#### User Registration
```dart
// Create new user with email and password
await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
);
```

#### User Login
```dart
// Sign in existing user
await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: email,
  password: password,
);
```

#### Success/Error Messages
```dart
// Display success or error messages
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Login Successful')),
);
```

### 3. Verify User Creation in Firebase Console
After signup:
- Go to **Firebase Console** → **Authentication** → **Users**
- Your new user should appear in the table with registered email
- This confirms your app is correctly communicating with Firebase Auth

### 4. Handle Authentication State (Optional But Recommended)
```dart
// Listen to authentication state changes
FirebaseAuth.instance.authStateChanges().listen((User? user) {
  if (user != null) {
    print("Logged in as ${user.email}");
    // Navigate to home screen
  } else {
    print("User logged out");
    // Navigate to login screen
  }
});
```

### 5. Logout Functionality (Optional Enhancement)
```dart
// Handle user logout
await FirebaseAuth.instance.signOut();
```

### 6. Test and Verify
Ensure that:
- ✅ Signup works without crashing
- ✅ Login works with valid credentials
- ✅ Login fails with incorrect credentials (and shows an error)
- ✅ New users appear in Firebase Console
- ✅ Capture screenshots for your README

### 7. Screenshot Requirements for README
Your README.md must include:

#### Authentication Screenshots:
- ✅ Login screen UI
- ✅ Signup screen UI
- ✅ Firebase Console "Users" table
- ✅ App showing login success message

#### Firebase Console Verification:
- ✅ Authentication enabled screenshot
- ✅ User registration confirmation
- ✅ Email/Password method enabled

### 8. Reflection Questions

#### Why Firebase Auth is useful?
Firebase Authentication provides:
- **Secure authentication** - Industry-standard security
- **Multiple providers** - Email, social, phone auth
- **Session management** - Automatic token handling
- **Cross-platform** - Works on iOS, Android, Web
- **Scalability** - Handles millions of users
- **Integration** - Works seamlessly with other Firebase services

#### Challenges faced during implementation:
1. **Error Handling**: Different Firebase error codes required specific user messages
2. **State Management**: Proper auth state changes needed for UI updates
3. **Form Validation**: Client-side validation before Firebase calls
4. **User Experience**: Loading states and success/error feedback
5. **Security**: Proper password requirements and email verification

#### How this helps your team integrate more Firebase features later:
The authentication foundation enables:
- **Social Login**: Easy addition of Google, Facebook, Apple sign-in
- **Phone Authentication**: SMS verification capabilities
- **Multi-factor Auth**: Enhanced security features
- **User Profiles**: Link auth data to user profiles
- **Permissions**: Role-based access control
- **Analytics**: Track user behavior and engagement
- **Cloud Functions**: Server-side authentication logic

## 📸 Firebase Integration Verification

### Terminal Logs
```
Firebase initialized successfully
Application finished.
```

### Firebase Console
- ✅ Firebase project created: "safestride-65dd6"
- ✅ Authentication enabled
- ✅ Firestore database created
- ✅ Real-time data synchronization working

## 🔥 Firestore Data Reading Implementation

### Overview
This project demonstrates comprehensive Firestore data reading capabilities with real-time updates. The implementation includes:

1. **Collection Reading**: Reading all documents from 'tasks', 'routes', and 'posts' collections
2. **Real-time Updates**: Using StreamBuilder for live data synchronization
3. **Single Document Reading**: Fetching specific documents by ID with real-time listeners
4. **Query Filtering**: Reading documents with specific conditions
5. **Error Handling**: Comprehensive error states and fallback values
6. **Document-level Listeners**: Real-time updates for individual documents

## ⚡ Real-Time Synchronization Implementation

### Real-Time Sync Explanation
Real-time synchronization allows your Flutter app to update instantly whenever data changes in Firestore, eliminating the need for manual refreshes. This creates a seamless user experience perfect for:

- **Chat Applications**: Instant message delivery
- **Live Dashboards**: Real-time analytics and metrics
- **Collaborative Tools**: Multi-user document editing
- **Social Feeds**: Instant post and comment updates
- **Notification Systems**: Real-time alerts and status changes

### Collection-Level Listeners
Collection listeners trigger when any document in the collection changes:

```dart
// Collection changes - triggers on add, edit, delete
FirebaseFirestore.instance
  .collection('posts')
  .snapshots();

// Triggers when:
// - A new post is added
// - A post is edited  
// - A post is deleted
```

### Document-Level Listeners
Document listeners trigger when specific fields in a document change:

```dart
// Document changes - triggers on field updates
FirebaseFirestore.instance
  .collection('users')
  .doc(userId)
  .snapshots();

// Triggers when:
// - Any field in the document changes
// - Server timestamps update
// - Nested fields are modified
```

### StreamBuilder Implementation
```dart
StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('posts').snapshots(),
  builder: (context, snapshot) {
    // Handle loading state
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    
    // Handle error state
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }
    
    // Handle empty state
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(child: Text('No posts yet'));
    }
    
    // Display data
    final docs = snapshot.data!.docs;
    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(docs[index]['title']),
          subtitle: Text(docs[index]['content']),
        );
      },
    );
  },
);
```

### Document-Level StreamBuilder
```dart
StreamBuilder<DocumentSnapshot>(
  stream: FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || !snapshot.data!.exists) {
      return const Text('User not found');
    }

    final userData = snapshot.data!.data() as Map<String, dynamic>;
    return Column(
      children: [
        Text('Name: ${userData['name'] ?? 'Not set'}'),
        Text('Email: ${userData['email'] ?? 'Not set'}'),
        Text('Last Updated: ${userData['lastUpdated'] ?? 'Never'}'),
      ],
    );
  },
);
```

### Enhanced Firestore Service Methods
```dart
// Collection-level real-time listeners
Stream<QuerySnapshot> getAllRoutes() {
  return _db.collection('routes').snapshots();
}

Stream<QuerySnapshot> getRoutesByType(String routeType) {
  return _db
      .collection('routes')
      .where('type', isEqualTo: routeType)
      .snapshots();
}

// Document-level real-time listeners
Stream<DocumentSnapshot> getRouteByIdStream(String routeId) {
  return _db.collection('routes').doc(routeId).snapshots();
}

Stream<DocumentSnapshot> getUserDataStream(String uid) {
  return _db.collection('users').doc(uid).snapshots();
}
```

### Reading Collections and Documents
```dart
// Read all documents from a collection
final snapshot = await FirebaseFirestore.instance
  .collection('tasks')
  .get();

// Real-time updates with snapshots
FirebaseFirestore.instance
  .collection('tasks')
  .snapshots();

// Read a single document
final doc = await FirebaseFirestore.instance
  .collection('users')
  .doc('userId')
  .get();

// Query with conditions
FirebaseFirestore.instance
  .collection('routes')
  .where('type', isEqualTo: 'running')
  .snapshots();
```

### Error Handling and Data Validation
```dart
// Safe data access with fallback values
title: Text(task['title'] ?? 'Untitled Task'),
description: Text(task['description'] ?? 'No description'),

// Check document existence
if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
  // Process data
}

// Handle connection states
if (snapshot.connectionState == ConnectionState.waiting) {
  return CircularProgressIndicator();
}
```

### Firestore Demo Screen Features
- **Real-time Task Management**: Add, complete, and delete tasks
- **Live Updates**: Instant UI updates when data changes in Firebase Console
- **Error Handling**: Comprehensive error states with user-friendly messages
- **Data Validation**: Safe data access with fallback values
- **Interactive UI**: Checkbox for task completion, swipe to delete

### Testing Real-Time Behavior
To test real-time synchronization:

1. **Open the Real-Time Sync Demo** - Navigate via sync icon in home screen
2. **Open Firebase Console** - Go to Firestore Database section
3. **Test Collection Updates**:
   - Add a new document to the 'posts' collection
   - Edit an existing post's title or content
   - Delete a post document
   - Watch the app UI update instantly

4. **Test Document Updates**:
   - Select a user document in the 'users' collection
   - Update the user's name or email
   - Add a 'lastUpdated' timestamp
   - Watch the user profile section update immediately

5. **Verify Instant Updates**:
   - No manual refresh required
   - UI updates within milliseconds
   - Loading states handled gracefully
   - Error states displayed appropriately

### Screenshots

#### Real-Time Sync Demo Interface
![Real-time sync demo showing collection and document listeners](assets/images/realtime_sync_demo.png)

#### Firebase Console - Adding Post
![Firebase Console showing new post being added](assets/images/firestore_add_post.png)

#### App Updating Instantly
![App UI updating immediately after Firestore change](assets/images/realtime_update_instant.png)

#### Document-Level Updates
![User profile updating when document fields change](assets/images/document_listener_update.png)

## 📝 Reflection

### Why Real-Time Sync Improves User Experience
Real-time synchronization transforms user experience by providing:

1. **Instant Feedback**: Users see their actions reflected immediately
2. **Collaborative Experience**: Multiple users can work together seamlessly
3. **Reduced Cognitive Load**: No need to manually refresh or check for updates
4. **Modern Feel**: Apps feel responsive and alive
5. **Competitive Advantage**: Superior to traditional polling-based updates

### Real-Time Applications in SafeStride
In the final SafeStride app, real-time updates could be used for:

1. **Live Route Sharing**: Users see new routes as they're added by the community
2. **Real-time Reviews**: Route reviews appear instantly as users submit them
3. **Live Safety Alerts**: Safety warnings broadcast to all users in real-time
4. **Group Activities**: Live tracking of group runs or cycling events
5. **Chat System**: Real-time messaging between users on the same route
6. **Location Sharing**: Live position sharing during group activities

### Challenges Encountered

1. **Connection State Management**
   - **Challenge**: Handling loading, error, and success states simultaneously
   - **Solution**: Comprehensive ConnectionState checking with user-friendly feedback
   - **Learning**: Proper state management is crucial for good UX

2. **Performance Optimization**
   - **Challenge**: Preventing unnecessary re-renders with frequent updates
   - **Solution**: Strategic widget structure and efficient data access patterns
   - **Learning**: StreamBuilder optimization is key for smooth performance

3. **Error Recovery**
   - **Challenge**: Graceful handling of network interruptions and Firebase errors
   - **Solution**: Try-catch blocks with meaningful error messages and retry logic
   - **Learning**: Robust error handling prevents app crashes

4. **Data Consistency**
   - **Challenge**: Ensuring UI reflects actual database state
   - **Solution**: Proper snapshot handling and data validation
   - **Learning**: Always validate data before displaying to users

5. **Memory Management**
   - **Challenge**: Proper disposal of controllers and stream subscriptions
   - **Solution**: Lifecycle-aware resource management with dispose() methods
   - **Learning**: Memory leaks can cause performance issues over time

## 🌩 Firebase Cloud Functions Implementation

### Overview
This project demonstrates comprehensive Firebase Cloud Functions integration with both callable and event-based functions. The implementation includes:

1. **Callable Functions** - Direct function calls from Flutter app
2. **Event-Based Functions** - Automatic triggers from Firestore/Storage changes
3. **HTTP Functions** - REST API endpoints for external access
4. **Flutter Integration** - Complete service layer for function interaction

### Cloud Functions Setup

#### **Installation and Initialization**
```bash
# Install Firebase CLI globally
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Cloud Functions
firebase init functions

# Deploy functions
firebase deploy --only functions
```

#### **Function Types Implemented**

##### **1. Callable Functions**
```javascript
// Welcome message function
exports.sayHello = onCall((request) => {
  const name = request.data.name || "SafeStride User";
  const message = `Hello, ${name}! Welcome to SafeStride - your community-verified route companion!`;
  
  logger.info(`sayHello called with name: ${name}`);
  
  return {
    message: message,
    timestamp: new Date().toISOString(),
    app: "SafeStride"
  };
});

// Route validation function
exports.validateRoute = onCall((request) => {
  const routeData = request.data;
  
  // Validation rules
  const validationRules = {
    name: { required: true, minLength: 3, maxLength: 100 },
    distance: { required: true, min: 0.1, max: 1000 },
    type: { required: true, allowed: ["running", "cycling", "walking"] },
    safetyRating: { required: true, min: 1, max: 5 }
  };
  
  // Validation logic...
  return {
    isValid: errors.length === 0,
    errors: errors,
    validatedAt: new Date().toISOString()
  };
});

// Safety score calculation function
exports.calculateSafetyScore = onCall((request) => {
  const { routeType, distance, timeOfDay, weatherConditions } = request.data;
  
  let baseScore = 5.0;
  
  // Route type adjustments
  if (routeType === "running") baseScore += 0.5;
  if (routeType === "cycling") baseScore -= 0.2;
  
  // Time of day adjustments
  if (timeOfDay === "night") baseScore -= 1.0;
  if (timeOfDay === "morning") baseScore += 0.2;
  
  // Weather adjustments
  if (weatherConditions === "rain") baseScore -= 0.8;
  if (weatherConditions === "clear") baseScore += 0.3;
  
  const finalScore = Math.max(1.0, Math.min(5.0, baseScore));
  
  return {
    safetyScore: finalScore.toFixed(1),
    factors: { routeType, distance, timeOfDay, weatherConditions },
    calculatedAt: new Date().toISOString()
  };
});
```

##### **2. Event-Based Functions**
```javascript
// User creation trigger
exports.onUserCreate = onDocumentCreated("users/{userId}", (event) => {
  const userData = event.data.data();
  const userId = event.params.userId;
  
  logger.info("New user created", { userId, userData });
  
  // Initialize user preferences
  const userPrefs = {
    notifications: true,
    safetyAlerts: true,
    routeRecommendations: true,
    createdAt: new Date().toISOString()
  };
  
  logger.info("User preferences initialized", userPrefs);
  return null;
});

// Route creation trigger
exports.onRouteCreate = onDocumentCreated("routes/{routeId}", (event) => {
  const routeData = event.data.data();
  const routeId = event.params.routeId;
  
  logger.info("New route created", { routeId, routeData });
  
  // Flag low safety ratings for review
  if (routeData.safetyRating < 2.5) {
    logger.warn(`Low safety rating route detected: ${routeId}`, routeData);
  }
  
  return null;
});

// Storage upload trigger
exports.onFileUpload = onObjectFinalized("storage/{filePath}", (event) => {
  const object = event.data;
  const filePath = event.params.filePath;
  
  logger.info("File uploaded", { 
    filePath: filePath,
    contentType: object.contentType,
    size: object.size,
    timeCreated: object.timeCreated
  });
  
  // Check file size
  const maxSize = 5 * 1024 * 1024; // 5MB
  if (object.size > maxSize) {
    logger.warn(`Large file uploaded: ${filePath} (${object.size} bytes)`);
  }
  
  return null;
});
```

### Flutter Integration

#### **Cloud Functions Service**
```dart
import 'package:cloud_functions/cloud_functions.dart';

class CloudFunctionsService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  // Call welcome function
  Future<Map<String, dynamic>> sayHello({String? name}) async {
    try {
      final callable = _functions.httpsCallable('sayHello');
      final result = await callable.call({'name': name});
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      developer.log('Error calling sayHello: $e');
      rethrow;
    }
  }

  // Call route validation function
  Future<Map<String, dynamic>> validateRoute(Map<String, dynamic> routeData) async {
    try {
      final callable = _functions.httpsCallable('validateRoute');
      final result = await callable.call(routeData);
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      developer.log('Error calling validateRoute: $e');
      rethrow;
    }
  }

  // Call safety score function
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
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      developer.log('Error calling calculateSafetyScore: $e');
      rethrow;
    }
  }
}
```

### Testing Cloud Functions

#### **1. Deploy Functions**
```bash
# Deploy all functions
firebase deploy --only functions

# Deploy specific function
firebase deploy --only functions:sayHello
```

#### **2. Test in Flutter App**
```dart
// Test callable function
final result = await _functionsService.sayHello(name: 'SafeStride User');
print(result['message']); // "Hello, SafeStride User! Welcome to SafeStride..."

// Test route validation
final routeData = {
  'name': 'Test Route',
  'distance': 5.2,
  'type': 'running',
  'safetyRating': 4.5,
};
final validation = await _functionsService.validateRoute(routeData);
print(validation['isValid']); // true/false

// Test safety score calculation
final safetyScore = await _functionsService.calculateSafetyScore(
  routeType: 'running',
  distance: 5.2,
  timeOfDay: 'morning',
  weatherConditions: 'clear',
);
print(safetyScore['safetyScore']); // "5.2"
```

#### **3. View Logs in Firebase Console**
1. **Open Firebase Console** → Functions → Logs
2. **Select Function** from dropdown
3. **View Execution Logs** with timestamps and input/output
4. **Monitor Performance** and error rates

### Screenshots

#### Cloud Functions Demo Interface
![Cloud Functions demo showing callable and event-based testing](assets/images/cloud_functions_demo.png)

#### Firebase Console Logs
![Firebase Console showing function execution logs](assets/images/firebase_functions_logs.png)

#### Flutter App Output
![Flutter app displaying Cloud Functions results](assets/images/cloud_functions_app_output.png)

### Reflection

#### **Why Serverless Functions Simplify Backend Logic**
1. **No Server Management** - No need to provision, maintain, or scale servers
2. **Automatic Scaling** - Functions scale automatically based on demand
3. **Cost-Effective** - Pay only for actual execution time, not idle servers
4. **Global Distribution** - Functions run in Google's global infrastructure
5. **Event-Driven** - Automatic execution based on data changes
6. **Language Flexibility** - Use JavaScript/TypeScript with full Node.js ecosystem
7. **Integrated Security** - Built-in Firebase authentication and authorization
8. **Real-Time Processing** - Instant response to user actions and data changes

#### **Use Cases in SafeStride**
1. **Route Validation** - Validate route data before saving to Firestore
2. **Safety Score Calculation** - Calculate dynamic safety scores based on conditions
3. **User Onboarding** - Initialize preferences and send welcome messages
4. **Route Analytics** - Track route creation, updates, and statistics
5. **File Processing** - Process uploaded images and generate thumbnails
6. **Notification System** - Send safety alerts and route recommendations
7. **Data Aggregation** - Generate reports and insights from route data
8. **Automated Moderation** - Flag low-rated routes for review

#### **Challenges Encountered**

1. **Project Plan Requirements**
   - **Challenge**: Firebase project needed Blaze plan for Cloud Functions
   - **Solution**: Upgrade project billing plan in Firebase Console
   - **Learning**: Always check project requirements before implementation

2. **ESLint Configuration**
   - **Challenge**: Strict ESLint rules blocking deployment
   - **Solution**: Configure appropriate ESLint rules or disable for deployment
   - **Learning**: Development tools need flexible configuration for different environments

3. **Function Testing**
   - **Challenge**: Testing functions locally before deployment
   - **Solution**: Use Firebase emulators and comprehensive test suites
   - **Learning**: Local testing environment is crucial for development workflow

4. **Error Handling**
   - **Challenge**: Proper error handling and logging across different function types
   - **Solution**: Implement consistent error patterns and structured logging
   - **Learning**: Robust error handling is essential for production reliability

5. **Performance Optimization**
   - **Challenge**: Cold starts and function execution time
   - **Solution**: Implement proper function initialization and caching strategies
   - **Learning**: Serverless performance requires different optimization techniques

### Future Enhancements
- **Scheduled Functions** - Daily route statistics and cleanup tasks
- **Function Composition** - Chain multiple functions for complex workflows
- **Custom Triggers** - Implement custom event triggers for specific use cases
- **Performance Monitoring** - Detailed metrics and alerting systems
- **A/B Testing** - Deploy multiple function versions for testing
- **Regional Deployment** - Deploy functions to multiple regions for latency optimization

## � Firebase Cloud Messaging (FCM) Implementation

### Overview
This project demonstrates comprehensive Firebase Cloud Messaging (FCM) integration for push notifications. The implementation includes:

1. **Permission Handling** - Request and manage notification permissions
2. **Device Token Management** - Retrieve and store FCM tokens
3. **Message Listeners** - Handle foreground, background, and terminated app states
4. **Topic Subscriptions** - Subscribe/unsubscribe to notification topics
5. **Real-time Demo** - Interactive UI to test FCM functionality

### FCM Setup and Configuration

#### **Dependencies Added**
```yaml
# 🔥 Firebase
firebase_messaging: ^15.0.0

# 🔔 Notifications
permission_handler: ^11.0.0
```

#### **Platform Configuration**

##### **Android Configuration**
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<application>
    <service
        android:name=".MyFirebaseMessagingService"
        android:exported="false">
        <intent-filter>
            <action android:name="com.google.firebase.MESSAGING_EVENT" />
        </intent-filter>
    </service>
</application>
```

##### **iOS Configuration**
```xml
<!-- ios/Runner/Info.plist -->
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
</array>
```

### FCM Service Implementation

#### **Core Service Class**
```dart
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _fcmToken;
  final StreamController<Map<String, dynamic>> _messageStreamController = 
      StreamController<Map<String, dynamic>>.broadcast();

  // Initialize FCM with permissions and listeners
  Future<void> initialize() async {
    await _requestPermission();
    await _getFCMToken();
    _setupMessageListeners();
  }

  // Request notification permissions
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
    }

    if (Platform.isAndroid) {
      await Permission.notification.request();
    }
  }

  // Get and save FCM token
  Future<void> _getFCMToken() async {
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      _fcmToken = token;
      await _saveTokenToPrefs(token);
      debugPrint('FCM Token: $token');
    }
  }

  // Setup message listeners
  void _setupMessageListeners() {
    // Handle messages when app is in foreground
    FirebaseMessaging.onMessage.listen(_handleMessage);

    // Handle messages when app is in background but opened
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((token) {
      _fcmToken = token;
      _saveTokenToPrefs(token);
    });
  }

  // Handle incoming messages
  void _handleMessage(RemoteMessage message) {
    debugPrint('Received message: ${message.messageId}');
    _messageStreamController.add({
      'title': message.notification?.title ?? 'New Notification',
      'body': message.notification?.body ?? 'You have a new message',
      'data': message.data,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
```

### Flutter Integration

#### **FCM Demo Screen**
```dart
class FCMDemoScreen extends StatefulWidget {
  const FCMDemoScreen({super.key});

  @override
  State<FCMDemoScreen> createState() => _FCMDemoScreenState();
}

class _FCMDemoScreenState extends State<FCMDemoScreen> {
  final FCMService _fcmService = FCMService();
  String? _fcmToken;
  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _initializeFCM();
  }

  Future<void> _initializeFCM() async {
    await _fcmService.initialize();
    
    // Listen to incoming messages
    _fcmService.messageStream.listen((message) {
      setState(() {
        _messages.insert(0, message);
      });
    });

    // Get current token
    setState(() {
      _fcmToken = _fcmService.fcmToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FCM Demo')),
      body: Column(
        children: [
          // FCM Token display
          Card(
            child: ListTile(
              title: const Text('FCM Token'),
              subtitle: Text(_fcmToken ?? 'Loading...'),
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: _copyTokenToClipboard,
              ),
            ),
          ),
          
          // Topic subscription
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _topicController,
                    decoration: const InputDecoration(
                      labelText: 'Topic Name',
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _subscribeToTopic,
                        child: const Text('Subscribe'),
                      ),
                      ElevatedButton(
                        onPressed: _unsubscribeFromTopic,
                        child: const Text('Unsubscribe'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Messages list
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text(message['title']),
                  subtitle: Text(message['body']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

### Testing FCM Functionality

#### **1. Send Test Notification from Firebase Console**
1. **Open Firebase Console** → Cloud Messaging
2. **Create New Message** → Compose message
3. **Target**: Select your app or use FCM token
4. **Notification**: Enter title and body
5. **Send** the message
6. **Check** your Flutter app for the notification

#### **2. Send Topic-Based Notification**
```bash
# Subscribe to topic in your app
await _fcmService.subscribeToTopic('safestride_updates');

# Send notification via Firebase Console
# Target: Topic -> safestride_updates
```

#### **3. Send Direct Token Notification**
```bash
# Copy FCM token from the demo app
# Use token in Firebase Console to send direct notification
```

### Message Handling States

#### **Foreground Messages**
```dart
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  // App is in foreground
  // Show in-app notification or banner
  _showInAppNotification(message);
});
```

#### **Background Messages**
```dart
FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  // App was in background, user tapped notification
  // Navigate to specific screen based on message data
  _handleNotificationTap(message);
});
```

#### **Terminated App Messages**
```dart
// Get initial message when app was terminated
RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
if (initialMessage != null) {
  _handleMessage(initialMessage);
}
```

### Platform-Specific Considerations

#### **Android Requirements**
- **Target SDK**: 33+ for notification permission handling
- **Manifest**: Declare FirebaseMessagingService
- **Icons**: Configure notification icons in `res/drawable`

#### **iOS Requirements**
- **APNs Certificate**: Configure in Apple Developer Portal
- **Capabilities**: Enable Push Notifications in Xcode
- **Background Modes**: Add Remote Notifications capability

#### **Web Requirements**
- **Service Worker**: Configure for web push notifications
- **Manifest**: Include gcm_sender_id
- **HTTPS**: Required for web notifications

### Advanced Features

#### **Custom Data Payloads**
```dart
// Send custom data with notification
{
  "notification": {
    "title": "New Route Added",
    "body": "Check out this amazing running route!"
  },
  "data": {
    "route_id": "abc123",
    "type": "running",
    "action": "view_route"
  }
}
```

#### **Notification Channels (Android)**
```dart
// Create notification channels for different types
AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
);
```

#### **Silent Notifications**
```dart
// Send data-only messages for background processing
{
  "data": {
    "type": "route_update",
    "route_id": "abc123"
  }
  // No notification field = silent message
}
```

### Screenshots

#### FCM Demo Interface
![FCM demo showing token, topics, and messages](assets/images/fcm_demo.png)

#### Push Notification Received
![Push notification displayed on device](assets/images/push_notification.png)

#### Firebase Console Messaging
![Firebase Console Cloud Messaging interface](assets/images/fcm_console.png)

### Use Cases in SafeStride

1. **Route Updates** - Notify users about new routes in their area
2. **Safety Alerts** - Send safety warnings for specific routes
3. **Community Updates** - Notify about route reviews and ratings
4. **Achievement Notifications** - Celebrate user milestones
5. **Event Reminders** - Notify about upcoming running events
6. **Weather Alerts** - Send weather-based route recommendations
7. **Social Features** - Notify about friend activities and challenges
8. **System Messages** - Important app updates and maintenance notices

### Challenges and Solutions

#### **Permission Handling**
- **Challenge**: Users denying notification permissions
- **Solution**: Graceful fallback to in-app notifications and clear permission explanations

#### **Token Management**
- **Challenge**: Token refresh and synchronization
- **Solution**: Automatic token refresh listeners and server-side token storage

#### **Background Processing**
- **Challenge**: Handling messages when app is terminated
- **Solution**: Proper initial message handling and background message configuration

#### **Platform Differences**
- **Challenge**: Different notification behaviors across platforms
- **Solution**: Platform-specific configurations and unified message handling

#### **Testing and Debugging**
- **Challenge**: Testing push notifications in development
- **Solution**: Firebase Console testing and local notification simulators

### Future Enhancements
- **Local Notifications** - Integrate flutter_local_notifications for better UX
- **Rich Media** - Support for images, videos, and interactive notifications
- **Scheduled Notifications** - Time-based and location-based notifications
- **Analytics** - Track notification delivery and engagement metrics
- **A/B Testing** - Test different notification content and timing
- **Smart Notifications** - AI-powered notification timing and content optimization

## �🔐 Firebase Security Rules

### Current Status
**⚠️ IMPORTANT**: Security rules need to be deployed to Firebase Console for production use.

### Security Rules Implementation
Proper security rules have been created in `firestore.rules` file:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection - only authenticated users can read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Routes collection - authenticated users can read, only owners can write
    match /routes/{routeId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
        request.auth.uid == resource.data.createdBy;
      allow delete: if request.auth != null && 
        request.auth.uid == resource.data.createdBy;
    }
    
    // Posts collection - authenticated users can read/write their own posts
    match /posts/{postId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && 
        request.auth.uid == resource.data.authorId;
      allow update, delete: if request.auth != null && 
        request.auth.uid == resource.data.authorId;
    }
    
    // Tasks collection - authenticated users can manage their own tasks
    match /tasks/{taskId} {
      allow read, write: if request.auth != null && 
        request.auth.uid == resource.data.userId;
    }
    
    // Reviews and favorites subcollections with proper access control
    match /routes/{routeId}/reviews/{reviewId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null && 
        request.auth.uid == resource.data.reviewerId;
    }
    
    match /users/{userId}/favorites/{routeId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### Security Features Implemented

#### **Authentication Required**
- All collections require `request.auth != null` for access
- Prevents anonymous users from reading/writing data

#### **Ownership-Based Access**
- Users can only modify their own data (`request.auth.uid == userId`)
- Route creators can only edit/delete their routes
- Post authors can only modify their posts

#### **Collection-Specific Rules**
- **Users**: Personal data access only
- **Routes**: Public read, owner write/delete
- **Posts**: Public read, author write/delete
- **Tasks**: Personal task management
- **Reviews**: Public read, reviewer write/delete

### Deployment Instructions

1. **Open Firebase Console** → Firestore Database → Rules tab
2. **Replace existing rules** with content from `firestore.rules` file
3. **Publish rules** to apply security settings
4. **Test access** with different user accounts

### Security Best Practices

#### **Data Validation**
```javascript
match /routes/{routeId} {
  allow create: if request.auth != null &&
    request.resource.data.matches({
      name: isString,
      distance: isNumber,
      type: isString && (type in ['running', 'cycling'])
    });
}
```

#### **Rate Limiting**
```javascript
match /posts/{postId} {
  allow create: if request.auth != null &&
    request.time < resource.data.timestamp + duration(1, 'h');
}
```

#### **Data Size Limits**
```javascript
match /tasks/{taskId} {
  allow write: if request.auth != null &&
    request.resource.data.size() < 1000;
}
```
- ✅ Firestore database created
- ✅ Collections: users, routes, reviews

## 💭 Reflection

### How does FlutterFire CLI simplify Firebase setup?
FlutterFire CLI automates the complex process of connecting Firebase services to Flutter apps. It handles:
- Automatic Firebase project configuration
- Platform-specific setup (Android/iOS/Web)
- Generation of firebase_options.dart with correct configuration
- Dependency management for Firebase packages

This eliminates manual configuration errors and reduces setup time from hours to minutes.

### What issues did you face and how did you fix them?
1. **Import path errors**: Fixed by adding proper Firebase imports and creating missing service files
2. **Const keyword issues**: Resolved by removing problematic const declarations with dynamic values
3. **Color constant errors**: Fixed by using direct Colors.green instead of Colors.green[800] in const contexts
4. **Missing User class**: Added Firebase Auth import to resolve User type references
5. **Syntax errors in home_screen.dart**: Recreated the file with proper syntax and structure

### How will this help your team integrate more Firebase features later?
The foundation we've built provides:
- **Scalable service architecture**: Auth and Firestore services can be extended
- **Proper error handling**: Template for future Firebase integrations
- **Clean project structure**: Easy to add new Firebase services (Storage, Functions, Analytics)
- **Working authentication flow**: Can be extended with social login, phone auth
- **Firestore patterns**: Established patterns for real-time data, queries, and updates

This setup enables rapid addition of features like:
- Firebase Storage for route images
- Cloud Functions for complex business logic
- Firebase Analytics for user behavior tracking
- Firebase Cloud Messaging for notifications
- Firebase Dynamic Links for route sharing

## �📁 Project Structure

```
SafeStride/
├── lib/                 # Flutter application code
│   ├── screens/          # UI screens
│   ├── services/         # Firebase services
│   ├── models/           # Data models
│   └── widgets/          # Reusable components
├── android/            # Android-specific files (if needed)
├── ios/                # iOS-specific files (if needed)
├── web/                # Web-specific files
├── test/               # Test files
├── assets/             # Images and assets
│   └── images/         # App images
├── docs/               # Documentation (HLD, LLD)
│   ├── HLD.md          # High-Level Design
│   └── LLD.md          # Low-Level Design
├── figma/              # Design files (if available)
└── README.md           # This file
# 🚶 SafeStride – Mobile Safety Application

## 📌 Project Overview

SafeStride is a Flutter-based mobile application designed to enhance user safety by providing location-aware features, responsive UI, and real-time functionality.
The project is developed collaboratively by a team using GitHub with a feature-branch workflow and pull requests.

---

## 👨‍💻 Team Workflow

* Repository managed using GitHub
* Each feature is developed in a separate branch
* Pull Requests (PRs) are created for every completed feature
* Code is reviewed before merging into the main branch

---

## ✨ Features

* 📱 Responsive mobile UI
* 📍 Location-based safety functionality
* ⚡ Fast and smooth Flutter performance
* 🧩 Modular feature-based structure
* 🔄 Continuous updates via PR workflow

---

## 🛠️ Tech Stack

* Flutter
* Dart
* Git & GitHub

---

## 🚀 Getting Started

### 1️⃣ Clone the repository

```
git clone <your-repo-link>
```

### 2️⃣ Go to project folder

```
cd SafeStride
```

### 3️⃣ Install dependencies

```
flutter pub get
```

### 4️⃣ Run the app

```
flutter run
```

---

## 📂 Project Structure (Example)

```
lib/
 ├── screens/
 ├── widgets/
 ├── models/
 ├── services/
 └── main.dart
```

---

## 🌿 Git Branch Naming Convention

```
feature/<feature-name>
bugfix/<issue-name>
```

Example:

```
feature/login-ui
feature/responsive-design
```

---

## ✅ Pull Request Rules

* Create a new branch for every feature
* Keep PR small and focused
* Add proper description
* Test before submitting

---

## 📬 Contribution

1. Fork the repo
2. Create your feature branch
3. Commit your changes
4. Push to branch
5. Open Pull Request

---

## 📄 License

This project is developed for academic/work collaboration purposes.
