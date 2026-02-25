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

### Future Enhancements
- **Offline Support**: Full offline capabilities with intelligent sync
- **Conflict Resolution**: Handle simultaneous edits from multiple users
- **Batch Updates**: Optimize multiple document operations
- **Security Rules**: Implement proper Firestore security for real-time access
- **Performance Monitoring**: Track real-time update performance metrics
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
