# Jess Fitness - Mobile Fitness App 💪

A comprehensive mobile fitness application built with **Flutter**, inspired by Jet Fitness. Track your workouts, browse exercises, and monitor your fitness progress all in one place!

## Features

- 🔐 **Login Screen**: Beautiful authentication with email/password and social login options
- 🏠 **Home Dashboard**: View fitness categories and quick stats
- 💪 **Workout Tracker**: Manage and track your workout routines
- 📚 **Exercise Library**: Browse and search through a comprehensive exercise database
- 👤 **Profile & Progress**: Monitor your achievements, goals, and statistics
- 🎨 **Beautiful UI**: Modern, intuitive interface with smooth navigation

## Tech Stack

- Flutter
- Dart
- Material Design 3

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio (IDE)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/somkheartk/jess-fitness.git
cd jess-fitness
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Available Commands

- `flutter pub get` - Install dependencies
- `flutter run` - Run the app on connected device/emulator
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app (macOS only)
- `flutter test` - Run tests

## Project Structure

```
jess-fitness/
├── lib/
│   ├── main.dart                  # Main app entry point
│   ├── screens/
│   │   ├── login_screen.dart      # Login/Authentication
│   │   ├── home_screen.dart       # Home dashboard
│   │   ├── workout_screen.dart    # Workout tracker
│   │   ├── exercises_screen.dart  # Exercise library
│   │   └── profile_screen.dart    # User profile
│   └── widgets/                   # Reusable widgets
├── assets/                        # Images, icons, fonts
├── android/                       # Android specific files
├── ios/                           # iOS specific files
├── test/                          # Unit and widget tests
└── pubspec.yaml                   # Dependencies

```

## Features in Detail

### Login Screen
- Beautiful gradient design with app branding
- Email and password authentication with validation
- Password visibility toggle
- Forgot password functionality
- Social login buttons (Google, Facebook)
- Sign up link for new users
- Loading state with spinner
- Smooth navigation to main app after login

### Home Screen
- Quick stats overview (workouts, active days, calories)
- Browse workout categories (Strength, Cardio, Flexibility, HIIT, Yoga, Pilates)
- Beautiful card-based UI with color coding

### Workout Screen
- View your workout plan
- Track workout completion
- See workout details (duration, exercises, calories)
- Mark workouts as complete/incomplete
- Add custom workouts

### Exercise Library
- Search exercises by name
- Filter by category (Strength, Cardio, Flexibility, Core)
- View exercise details and difficulty levels
- Add exercises to your workout

### Profile Screen
- View comprehensive statistics
- Track goals and progress with visual indicators
- Unlock achievements
- Manage settings and preferences

## Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web (with minor adjustments)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

ISC

## Author

Created with ❤️ for fitness enthusiasts using Flutter