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

## 📁 Project Structure

```
SafeStride/
├── lib/                 # Flutter application code
├── android/            # Android-specific files
├── ios/                # iOS-specific files
├── test/               # Test files
├── assets/             # Images and assets
├── docs/               # Documentation (HLD, LLD)
├── figma/              # Design files
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

## Responsive UI Implementation

SafeStride includes a responsive home screen designed to adapt seamlessly across different screen sizes and orientations. The layout dynamically adjusts using Flutter’s MediaQuery, LayoutBuilder, and flexible widgets to ensure a consistent user experience on phones and tablets.

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
