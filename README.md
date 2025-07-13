# raja_c_flutter_biometrics

A new Flutter project as Take Home Assignment for biometrics authentication.

# Creating the Flutter Project
flutter create . --org com.raja.biometrics --platforms android --project-name raja_c_flutter_biometrics

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Clean Architecture Folder Structure:
```
lib/
├── main.dart
├── core/                  # Core domain logic and utilities
│   ├── errors/            # Custom exceptions
│   ├── extensions/        # Dart extensions
│   ├── models/            # Core data models
│   ├── repositories/      # Core repository interfaces
│   ├── themes/            # App theming
│   ├── usecases/          # Core business use cases
│   └── utils/             # Utility helpers and reusable code like mixins, extensions, and formatting functions
├── data/                  # Data layer (external concerns)
│   ├── datasources/       # Data sources (API, local)
│   ├── models/            # Data transfer objects
│   └── repositories/      # Repository implementations
├── domain/                # Domain layer (entities, usecases, repositories)
│   ├── entities/          # Business entities
│   ├── repositories/      # Domain repository interfaces
│   └── usecases/          # Domain use cases
├── presentation/          # Presentation layer (UI)
│   ├── blocs/             # State management (BLoC)
│   │   ├── auth/          # Auth BLoC
│   │   └── dash/          # Dashboard BLoC
│   ├── routes/            # Navigation and routing
│   ├── screens/           # UI screens/pages
│   └── widgets/           # Reusable UI components
│       ├── common/        # Common widgets (error, loading)
│       └── dash/          # Dashboard-specific widgets
├── services/              # Infrastructure services
│   └── biometric_service.dart
└── widgets/               # (Legacy or global widgets)
```

### Core Principles:

1. Dependency Inversion: Outer layers depend on inner layers, not vice versa
2. Separation of Concerns: Each layer has a specific responsibility
3. Testability: Business logic is isolated and easily testable
4. Maintainability: Changes in one layer don't affect others

### In Your Flutter Project:

-  core/ = Domain layer (pure Dart, no Flutter dependencies)
-  data/ = Data access implementations
-  blocs/ = State management (part of presentation)
-  services/ = External service integrations

This structure is recommended by:
- Flutter community
- Robert C. Martin (Clean Architecture book)
- Google's Flutter team
- Enterprise Flutter applications
- It provides excellent scalability, testability, and maintainability for medium to large Flutter projects.

### Creating the Folders:

```
mkdir -p lib/presentation/{blocs,screens,widgets,routes} lib/core/{usecases,errors} lib/data/{datasources,models}
```

## Running the App

1. Make sure you have an Android emulator running or a physical device connected.
2. Run the Flutter app using the following command:
```
flutter run

```
3. The app should open on your device and you can start using it.

## Additional Notes

- This project uses the `flutter_local_auth` package for biometrics authentication.
- Make sure you have enabled biometrics on your device before running the app.
- The app only supports fingerprint authentication.
- The app is written in Flutter version 3.10.6.
- The app is compatible with Android version 10.0 (Q) and above.
- The app is written in Dart version 3.0.6.
- The app is written in Android Studio version 2022.2.1.
- The app is written in Java version 11.
- The app is written in Kotlin version 1.8.21.

## Static Code Analysis

`analysis_options.yaml` file is added to the project to enable static code analysis. The file has configured additional rules to check for while performing the Static Code Analysis.

# Read the current project folder structure inside the lib directory

find lib -type f -name "*.dart" | sort

# Verify the directory tree structure of the lib folder

tree lib/ -a

# Moved the themes.dart file to the proper location in theme for better architecture organization

mkdir -p lib/core/theme

# To execute the lanes in your Fastfile, run these commands from your android directory in the terminal:

## For the CI lane:

fastlane ci

## For the CD lane:

fastlane cd

REMEMBER to:
● Use BLoC pattern with separation of concerns
● Use animations for button taps and transitions
● Reusability of components
● Make design be Responsive and supported for both mobile and tablets
● Support for Face ID - Android(Compulsory) and
(iOS)(Optional)
● Support for Fingerprint - both Android and iOS
● Uses platform's default (SF Pro on iOS, Inter on Android)

FOCUS on:
● Code structure
● Architecture decisions
● Error handling
● Best practices - SOLID Principles & Clean Code Principles
● Implementation of everything based on the current directory tree structure of the lib folder
