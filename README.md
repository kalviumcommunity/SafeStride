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
