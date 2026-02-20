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

## 🔥 Firebase Setup Commands

### Installation and Configuration
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase project
flutterfire configure

# Initialize Firebase in your app
flutter pub add firebase_core firebase_auth cloud_firestore
```

### Firebase Initialization Code
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SafeStrideApp());
}
```

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

## 📋 Project Information

**Project Type**: Work Integration Project  
**Team Size**: 3 Members  
**Duration**: 4 Weeks  
**Course**: Simulated Work Curriculum  
**Team Members**: Amulya, Yashika, Mithun

---

**SafeStride** - Making urban running and cycling safer, one route at a time. 🏃‍♂️🚴‍♀️
