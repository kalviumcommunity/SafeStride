SafeStride – Community-Verified Routes for Urban Runners & Cyclists

A cross-platform mobile application that helps runners and cyclists discover safe, community-validated routes using real user reviews, ratings, and shared experiences.

🎯 Project Overview

SafeStride addresses the common problem faced by urban runners and cyclists who lack access to safe, well-reviewed routes. Our platform enables users to discover trusted paths validated by the community, making informed decisions before choosing their routes.

🚀 Core Features (MVP)
User Features

User Authentication: Registration and login using Firebase Authentication

Route Discovery: Browse nearby running and cycling routes

Route Details: View comprehensive information including:

Distance

Route type (running/cycling)

Safety rating

User reviews

Community Contribution: Add new routes with basic details

Reviews & Ratings: Rate and review existing routes

System Features

Real-time Updates: Live updates of reviews and ratings

Community Safety Score: Aggregated safety ratings from the community

Data Validation: Basic validation and moderation system

🛠 Technology Stack
Frontend (Mobile App)

Flutter - Cross-platform mobile development

Dart - Programming language

Flutter Widgets - Responsive UI components

Backend & Services

Firebase Authentication - User authentication

Firebase Firestore - Real-time database

Firebase Cloud Storage - Optional image storage

Design

Figma - UI/UX design

Design Thinking - User-centric approach

👥 Team Roles
Member 1 – Flutter & UI Developer

Implement Flutter UI screens

Integrate Figma designs into Flutter

Handle navigation and responsiveness

Member 2 – Firebase & Backend Developer

Set up Firebase project

Implement authentication

Manage Firestore database (routes, users, reviews)

Real-time data integration

Member 3 – Project Manager & QA

Sprint planning and task tracking

Documentation (HLD, LLD)

Testing and validation

Assist in frontend/backend when needed

📅 4-Week Sprint Plan
Week 1 – Planning & Design

 Understand problem and define MVP

 Design wireframes in Figma

 Create High-Level Design (HLD)

 Set up Flutter and Firebase project

Deliverables:

 Wireframes

 HLD document

 Project setup

Week 2 – Core Development

 Implement user authentication

 Create basic Flutter screens

 Firestore schema design

 Add and fetch route data

Deliverables:

 Login & signup working

 Route listing screen

 Firestore integration

Week 3 – Community Features

 Ratings and reviews feature

 Safety score logic

 Route detail screen

 UI improvements and validations

Deliverables:

 Reviews & ratings functional

 Route details displayed correctly

 Stable app flow

Week 4 – Testing & Finalization

 Create Low-Level Design (LLD)

 End-to-end testing

 Bug fixing

 Final demo preparation and documentation

Deliverables:

 LLD document

 Tested MVP

 Final presentation/demo

📊 Success Criteria

 Users can log in and register successfully

 At least 8–10 routes added to app

 Each route supports reviews and ratings

 Safety score updates in real time

 App runs smoothly on web browser

 Project meets Sprint objectives

🎓 Curriculum Alignment

This project aligns with the simulated work curriculum through:

Flutter & Dart fundamentals

Firebase real-time data integration

Design thinking principles

High-Level and Low-Level Design documentation

Collaborative sprint-based development

🧪 Multi-Device Testing

Before showcasing or deploying the application, SafeStride was tested on multiple environments to ensure consistent functionality and performance.

Emulator Testing

Device: Medium Phone Emulator

Android Version: Android 16 (API 36.1)

Tool: Android Studio Emulator

Tests performed:

Application launch

Navigation between screens

UI responsiveness

Form inputs and button interactions

App lifecycle testing (minimize and reopen)

Result:
The application ran successfully on the Android emulator with no crashes. UI elements rendered correctly and navigation worked as expected.

Physical Device Testing

Device Type: Android smartphone

Connection Method: USB Debugging enabled

Tests performed:

Touch responsiveness

Internet connectivity behavior

Firebase authentication flow

Route browsing and navigation

Overall performance testing

Result:
The application worked smoothly on the physical device. All features behaved correctly and the UI remained responsive during interaction.

� Common Setup Issues
Issue	Cause	Solution
flutterfire not recognized	CLI not added to PATH	Add ~/.pub-cache/bin to PATH
Firebase not initialized	Missing await Firebase.initializeApp()	Add initialization in main()
Wrong Firebase project selected	Incorrect project chosen	Re-run flutterfire configure
Build fails	Gradle plugin missing	Add apply plugin: 'com.google.gms.google-services' in android/app/build.gradle
🔥 Firebase Setup Commands
Installation and Configuration
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase project
flutterfire configure

# Initialize Firebase in your app
flutter pub add firebase_core firebase_auth cloud_firestore
Firebase Initialization Code
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SafeStrideApp());
}
📸 Firebase Integration Verification
Terminal Logs
Firebase initialized successfully
Application finished.
Firebase Console

✅ Firebase project created: "safestride-65dd6"

✅ Authentication enabled

✅ Firestore database created

✅ Collections: users, routes, reviews

💭 Reflection
How does FlutterFire CLI simplify Firebase setup?

FlutterFire CLI automates the complex process of connecting Firebase services to Flutter apps. It handles:

Automatic Firebase project configuration

Platform-specific setup (Android/iOS/Web)

Generation of firebase_options.dart with correct configuration

Dependency management for Firebase packages

This eliminates manual configuration errors and reduces setup time from hours to minutes.

What issues did you face and how did you fix them?

Import path errors: Fixed by adding proper Firebase imports and creating missing service files

Const keyword issues: Resolved by removing problematic const declarations with dynamic values

Color constant errors: Fixed by using direct Colors.green instead of Colors.green[800] in const contexts

Missing User class: Added Firebase Auth import to resolve User type references

Syntax errors in home_screen.dart: Recreated the file with proper syntax and structure

How will this help your team integrate more Firebase features later?

The foundation we've built provides:

Scalable service architecture

Proper error handling

Clean project structure

Working authentication flow

Established Firestore patterns

This setup enables adding features like:

Firebase Storage

Cloud Functions

Firebase Analytics

Firebase Cloud Messaging

Dynamic Links

�📁 Project Structure
SafeStride/
├── lib/
│   ├── screens/
│   ├── services/
│   ├── models/
│   └── widgets/
├── android/
├── ios/
├── web/
├── test/
├── assets/
│   └── images/
├── docs/
│   ├── HLD.md
│   └── LLD.md
├── figma/
└── README.md
🚶 SafeStride – Mobile Safety Application
📌 Project Overview

SafeStride is a Flutter-based mobile application designed to enhance user safety by providing location-aware features, responsive UI, and real-time functionality.
The project is developed collaboratively by a team using GitHub with a feature-branch workflow and pull requests.

👨‍💻 Team Workflow

Repository managed using GitHub

Each feature is developed in a separate branch

Pull Requests (PRs) are created for every completed feature

Code is reviewed before merging into the main branch

✨ Features

📱 Responsive mobile UI

📍 Location-based safety functionality

⚡ Fast and smooth Flutter performance

🧩 Modular feature-based structure

🔄 Continuous updates via PR workflow

🛠️ Tech Stack

Flutter

Dart

Git & GitHub

🚀 Getting Started
1️⃣ Clone the repository
git clone <your-repo-link>
2️⃣ Go to project folder
cd SafeStride
3️⃣ Install dependencies
flutter pub get
4️⃣ Run the app
flutter run
📂 Project Structure (Example)
lib/
 ├── screens/
 ├── widgets/
 ├── models/
 ├── services/
 └── main.dart
🌿 Git Branch Naming Convention
feature/<feature-name>
bugfix/<issue-name>

Example:

feature/login-ui
feature/responsive-design
✅ Pull Request Rules

Create a new branch for every feature

Keep PR small and focused

Add proper description

Test before submitting

📬 Contribution

Fork the repo

Create your feature branch

Commit your changes

Push to branch

Open Pull Request

📄 License

This project is developed for academic/work collaboration purposes.