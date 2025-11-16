# Jess Fitness App - โครงสร้างโปรเจค

## โครงสร้างโฟลเดอร์

```
lib/
├── config/
│   └── constants.dart          # Constants และ configuration
├── models/
│   ├── user_model.dart         # User data model
│   ├── workout_model.dart      # Workout และ Exercise models
│   ├── progress_model.dart     # Progress tracking models
│   └── goal_model.dart         # Goal models
├── services/
│   ├── api_service.dart        # Base API service (HTTP client)
│   ├── auth_service.dart       # Authentication service
│   ├── workout_service.dart    # Workout-related API calls
│   ├── progress_service.dart   # Progress tracking API calls
│   └── goal_service.dart       # Goal management API calls
├── providers/
│   ├── auth_provider.dart      # Authentication state management
│   ├── workout_provider.dart   # Workout state management
│   ├── progress_provider.dart  # Progress state management
│   └── goal_provider.dart      # Goal state management
├── screens/
│   ├── login_screen.dart       # Login/Register screen
│   ├── home_screen.dart        # Home dashboard
│   ├── workout_detail_screen.dart  # Workout detail & exercise list
│   ├── progress_screen.dart    # Progress tracking & charts
│   └── profile_screen.dart     # User profile
├── core.dart                   # Central export file
└── main.dart                   # App entry point

```

## การใช้งาน

### 1. Models
Data models สำหรับ JSON serialization/deserialization:
- `User`: ข้อมูลผู้ใช้ (BMI, age calculations)
- `Workout`, `Exercise`: ข้อมูลการออกกำลังกาย
- `Progress`, `WeeklyProgress`: ข้อมูลความคืบหน้า
- `Goal`: เป้าหมาย (progress calculations)

### 2. Services
API communication layer:
- `apiService`: Base HTTP client (GET, POST, PUT, DELETE, PATCH)
- `authService`: Login, Register, Logout, Token management
- `workoutService`: CRUD operations for workouts/exercises
- `progressService`: Progress tracking operations
- `goalService`: Goal management operations

**Mock Data**: แต่ละ service มี mock methods (`getMockX()`) สำหรับทดสอบก่อนเชื่อม API จริง

### 3. Providers (State Management)
ใช้ Provider pattern สำหรับจัดการ state:
```dart
// ตัวอย่างการใช้งาน
final authProvider = Provider.of<AuthProvider>(context);
final workoutProvider = Provider.of<WorkoutProvider>(context);

// หรือใช้ Consumer
Consumer<AuthProvider>(
  builder: (context, auth, child) {
    return Text(auth.currentUser?.name ?? 'Guest');
  },
)
```

### 4. Constants
```dart
ApiConstants.baseUrl          // API base URL
ApiConstants.login            // API endpoints
AppConstants.workoutCategories // App constants
ValidationConstants.minPasswordLength // Validation rules
```

## การเชื่อมต่อ API

### แก้ไข Base URL
ใน `lib/config/constants.dart`:
```dart
static const String baseUrl = 'https://your-api.com/api';
```

### แก้ไขจาก Mock เป็น API จริง
ใน Services แต่ละตัว:
```dart
// จาก
_workouts = await _workoutService.getMockWorkouts();

// เป็น
_workouts = await _workoutService.getWorkouts();
```

### API Response Format
Services คาดหวัง response format:
```json
{
  "token": "jwt-token-here",
  "user": { ... },
  "data": [ ... ]
}
```

### Error Handling
```dart
try {
  await authProvider.login(email, password);
} catch (e) {
  // แสดง error message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(authProvider.errorMessage ?? 'Error')),
  );
}
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.5+1          # State management
  http: ^1.6.0                # HTTP client
  shared_preferences: ^2.5.3  # Local storage
  intl: ^0.20.2               # Date formatting
  fl_chart: ^1.1.1            # Charts
```

## การรัน

```bash
# Get dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome

# Run on Windows
flutter run -d windows
```

## Login Demo
- Email: `demo@jess.com`
- Password: `123456`

## ข้อมูล Mock
- Workouts: 2 workouts (Full Body, Morning Cardio)
- Exercises: 4 exercises (Overhead Press, Lunges, etc.)
- Progress: 7 days ของข้อมูล
- Goals: 5 goals (daily, weekly, monthly)

## Next Steps
1. เชื่อมต่อ Backend API
2. แทนที่ mock methods ด้วย API calls จริง
3. ทดสอบ error handling
4. เพิ่ม loading indicators
5. เพิ่ม offline support (optional)
