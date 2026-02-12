# SafeStride – Community-Verified Routes for Urban Runners & Cyclists

A cross-platform mobile application that helps runners and cyclists discover safe, community-validated routes using real user reviews, ratings, and shared experiences.

## 🎯 Project Overview

SafeStride addresses the common problem faced by urban runners and cyclists who lack access to safe, well-reviewed routes. Our platform enables users to discover trusted paths validated by the community, making informed decisions before choosing their routes.

## � Firebase Integration

This project demonstrates comprehensive Firebase integration including:

- **Firebase Authentication** for user signup/login
- **Cloud Firestore** for real-time data storage
- **Real-time updates** with StreamBuilder
- **CRUD operations** for routes and user data

### Firebase Setup Instructions

1. **Create Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create a new project named "SafeStride"

2. **Add Flutter App to Firebase**
   ```bash
   # Install FlutterFire CLI
   dart pub global activate flutterfire_cli
   
   # Configure Firebase for your project
   flutterfire configure
   ```

3. **Add Configuration Files**
   - Download `google-services.json` for Android → place in `android/app/`
   - Download `GoogleService-Info.plist` for iOS → place in `ios/Runner/`

4. **Update Firebase Options**
   - Replace placeholder values in `lib/firebase_options.dart` with your actual Firebase configuration

### Dependencies Added

```yaml
dependencies:
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^5.0.0
```

## � Core Features (MVP)

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
- [ ] Understand problem and define MVP
- [ ] Design wireframes in Figma
- [ ] Create High-Level Design (HLD)
- [ ] Set up Flutter and Firebase project

**Deliverables:**
- Wireframes
- HLD document
- Project setup

### Week 2 – Core Development
- [ ] Implement user authentication
- [ ] Create basic Flutter screens
- [ ] Firestore schema design
- [ ] Add and fetch route data

**Deliverables:**
- Login & signup working
- Route listing screen
- Firestore integration

### Week 3 – Community Features
- [ ] Ratings and reviews feature
- [ ] Safety score logic
- [ ] Route detail screen
- [ ] UI improvements and validations

**Deliverables:**
- Reviews & ratings functional
- Route details displayed correctly
- Stable app flow

### Week 4 – Testing & Finalization
- [ ] Create Low-Level Design (LLD)
- [ ] End-to-end testing
- [ ] Bug fixing
- [ ] Final demo preparation and documentation

**Deliverables:**
- LLD document
- Tested MVP
- Final presentation/demo

## 📊 Success Criteria

- [ ] Users can log in and register successfully
- [ ] At least 8–10 routes added to the app
- [ ] Each route supports reviews and ratings
- [ ] Safety score updates in real time
- [ ] App runs smoothly on Android emulator/device
- [ ] Project meets Sprint objectives

## 🎓 Curriculum Alignment

This project aligns with the simulated work curriculum through:
- Flutter & Dart fundamentals
- Firebase real-time data integration
- Design thinking principles
- High-Level and Low-Level Design documentation
- Collaborative sprint-based development

## 📱 Firebase Implementation Details

### Authentication Service (`lib/services/auth_service.dart`)

```dart
// Sign up with email and password
Future<User?> signUp(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  } catch (e) {
    debugPrint('Sign up error: $e');
    return null;
  }
}

// Log in existing user
Future<User?> signIn(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  } catch (e) {
    debugPrint('Sign in error: $e');
    return null;
  }
}
```

### Firestore Service (`lib/services/firestore_service.dart`)

```dart
// Add user data to Firestore
Future<void> addUserData(String uid, Map<String, dynamic> data) async {
  await FirebaseFirestore.instance.collection('users').doc(uid).set(data);
}

// Add a new route
Future<void> addRoute(Map<String, dynamic> routeData) async {
  await FirebaseFirestore.instance.collection('routes').add(routeData);
}

// Get all routes with real-time updates
Stream<QuerySnapshot> getAllRoutes() {
  return FirebaseFirestore.instance.collection('routes').snapshots();
}
```

### Real-time UI Updates

```dart
StreamBuilder<QuerySnapshot>(
  stream: _firestoreService.getAllRoutes(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasData) {
      final routes = snapshot.data!.docs;
      return ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index].data() as Map<String, dynamic>;
          return RouteCard(route: route);
        },
      );
    }
    return const Center(child: Text('No routes available'));
  },
)
```

## 📊 Firebase Database Schema

### Collections Structure

```
users/
  {userId}/
    name: string
    email: string
    createdAt: timestamp
    profileImage: string

routes/
  {routeId}/
    name: string
    type: string (running/cycling)
    distance: number
    safetyRating: number
    difficulty: string
    description: string
    createdAt: timestamp
    createdBy: string (userId)

routes/{routeId}/reviews/
  {reviewId}/
    userId: string
    rating: number
    comment: string
    createdAt: timestamp

users/{userId}/favorites/
  {routeId}/
    addedAt: timestamp
```

## 🧪 Testing Firebase Integration

### Test Cases Completed

1. **User Authentication**
   - ✅ User signup with email/password
   - ✅ User login with valid credentials
   - ✅ Password reset functionality
   - ✅ User logout

2. **Firestore Operations**
   - ✅ Add user data to Firestore
   - ✅ Create new routes
   - ✅ Read routes with real-time updates
   - ✅ Update existing routes
   - ✅ Delete routes

3. **Real-time Features**
   - ✅ StreamBuilder for live data updates
   - ✅ Auth state changes handling
   - ✅ Automatic UI updates on data changes

### How to Test

1. **Run the App**
   ```bash
   flutter run -d chrome --target=lib/main_firebase_test.dart
   ```

2. **Test Authentication Flow**
   - Create a new account
   - Login with the created account
   - Test password reset
   - Logout and login again

3. **Test Firestore Operations**
   - Add sample routes using the "Add Sample" button
   - Add custom routes using the floating action button
   - Verify data appears in Firebase Console
   - Test real-time updates by adding data from multiple devices

## 📁 Project Structure

```
SafeStride/
├── lib/
│   ├── main.dart                 # App entry point with Firebase initialization
│   ├── main_firebase_test.dart    # Firebase test version
│   ├── firebase_options.dart     # Firebase configuration
│   ├── services/
│   │   ├── auth_service.dart     # Authentication logic
│   │   └── firestore_service.dart # Firestore CRUD operations
│   └── screens/
│       ├── login_screen.dart     # Login UI
│       ├── signup_screen.dart    # Registration UI
│       └── home_screen.dart      # Main app interface
├── android/                      # Android-specific files
│   ├── app/
│   │   ├── google-services.json  # Firebase Android config
│   │   └── build.gradle          # Android app configuration
│   └── build.gradle              # Android project configuration
├── ios/                         # iOS-specific files (placeholder)
├── web/                         # Web-specific files
├── test/                        # Test files
│   └── widget_test.dart         # Widget tests
├── analysis_options.yaml        # Flutter linting rules
├── pubspec.yaml                 # Dependencies including Firebase
└── README.md                    # This file
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed
- Dart SDK installed
- Firebase account
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
2. Navigate to the project directory
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Set up Firebase project
5. Run the app:
   ```bash
   flutter run
   ```

## 📱 Screens

The app will include the following main screens:
- Login/Signup
- Home/Route Listing
- Route Details
- Add New Route
- Profile
- Reviews & Ratings

## 🔧 Firebase Schema

### Collections
- **users**: User profiles and authentication data
- **routes**: Route information (distance, type, coordinates)
- **reviews**: User reviews and ratings for routes

## � Firebase Benefits Reflection

### How Firebase Simplifies Backend Management

1. **No Server Setup Required**: Firebase handles all server infrastructure
2. **Real-time Database**: Automatic data synchronization across clients
3. **Built-in Authentication**: Secure user management with minimal code
4. **Scalable Storage**: Automatically scales with user growth
5. **Offline Support**: Data caching and offline persistence built-in

### Learning Experience

- **Cloud Integration**: Understanding client-server communication
- **Real-time Architecture**: Building responsive, live-updating applications
- **Authentication Flow**: Implementing secure user management
- **Database Design**: Structuring NoSQL data for mobile apps
- **Error Handling**: Managing network and authentication errors

## �📋 Project Information

**Project Type**: Work Integration Project  
**Team Size**: 3 Members  
**Duration**: 4 Weeks  
**Course**: Simulated Work Curriculum  
**Team Members**: Amulya, Yashika, Mithun

---

**SafeStride** - Making urban running and cycling safer, one route at a time. 🏃‍♂️🚴‍♀️
