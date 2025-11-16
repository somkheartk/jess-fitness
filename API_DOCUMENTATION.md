# Jess Fitness - API Documentation

## Overview

This document provides detailed information about the service layer integration between the Flutter app and the NestJS API backend.

## Architecture

```
Flutter App (Mobile)
    ↓
Service Layer (lib/services/)
    ↓
HTTP Requests
    ↓
NestJS API Backend
    ↓
MongoDB Database
```

## Flutter Service Layer

### Location
All services are located in `lib/services/` directory.

### Available Services

#### 1. API Service (`api_service.dart`)
Base service that handles all HTTP communication.

**Methods:**
- `get(endpoint)` - GET request
- `post(endpoint, data)` - POST request
- `put(endpoint, data)` - PUT request
- `delete(endpoint)` - DELETE request
- `setAuthToken(token)` - Set JWT token for authenticated requests
- `clearAuthToken()` - Clear authentication token

#### 2. Auth Service (`auth_service.dart`)
Handles user authentication and session management.

**Methods:**
- `login(email, password)` - Login user
- `register(email, password, name)` - Register new user
- `logout()` - Logout user
- `isLoggedIn()` - Check if user is logged in
- `getToken()` - Get stored JWT token
- `initialize()` - Initialize service with stored token

**Usage Example:**
```dart
final authService = AuthService();

// Login
try {
  final response = await authService.login('user@example.com', 'password123');
  print('Token: ${response['token']}');
} catch (e) {
  print('Login failed: $e');
}

// Check if logged in
final isLoggedIn = await authService.isLoggedIn();
```

#### 3. User Service (`user_service.dart`)
Manages user profile and statistics.

**Methods:**
- `getUserProfile(userId)` - Get user profile
- `updateUserProfile(userId, data)` - Update user profile
- `getUserStats(userId)` - Get user statistics

**Usage Example:**
```dart
final userService = UserService();

// Get user profile
final user = await userService.getUserProfile('userId123');
print('Name: ${user.name}');

// Update profile
final updatedUser = await userService.updateUserProfile(
  'userId123',
  {'name': 'New Name'},
);
```

#### 4. Workout Service (`workout_service.dart`)
Handles workout management.

**Methods:**
- `getWorkouts({category})` - Get all workouts, optionally filtered by category
- `getWorkoutById(workoutId)` - Get specific workout
- `createWorkout(data)` - Create new workout
- `updateWorkout(workoutId, data)` - Update workout
- `completeWorkout(workoutId)` - Mark workout as completed
- `deleteWorkout(workoutId)` - Delete workout

**Usage Example:**
```dart
final workoutService = WorkoutService();

// Get all workouts
final workouts = await workoutService.getWorkouts();

// Get workouts by category
final strengthWorkouts = await workoutService.getWorkouts(category: 'Strength');

// Complete workout
await workoutService.completeWorkout('workoutId123');
```

#### 5. Exercise Service (`exercise_service.dart`)
Manages exercise library.

**Methods:**
- `getExercises({category, difficulty, search})` - Get all exercises with optional filters
- `getExerciseById(exerciseId)` - Get specific exercise
- `createExercise(data)` - Create new exercise
- `updateExercise(exerciseId, data)` - Update exercise
- `deleteExercise(exerciseId)` - Delete exercise

**Usage Example:**
```dart
final exerciseService = ExerciseService();

// Get all exercises
final exercises = await exerciseService.getExercises();

// Search exercises
final results = await exerciseService.getExercises(
  category: 'Cardio',
  difficulty: 'Beginner',
  search: 'running',
);
```

### Data Models

Located in `lib/models/` directory:

- `User` - User profile model
- `Workout` - Workout model
- `Exercise` - Exercise model

Each model includes:
- `fromJson()` - Parse from API response
- `toJson()` - Convert to JSON for API requests

### Configuration

API configuration is located in `lib/config/api_config.dart`:

```dart
class ApiConfig {
  static const String baseUrl = 'http://localhost:3000/api';
  static const Duration timeoutDuration = Duration(seconds: 30);
}
```

**Important:** Update `baseUrl` to your production API URL before deploying.

## NestJS Backend API

### Base URL
`http://localhost:3000/api`

### Authentication

All protected endpoints require JWT token in the Authorization header:
```
Authorization: Bearer <your-jwt-token>
```

### Endpoints

#### Authentication (`/api/auth`)

**POST /api/auth/register**
Register a new user.

Request:
```json
{
  "email": "user@example.com",
  "password": "password123",
  "name": "John Doe"
}
```

Response:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "userId": "507f1f77bcf86cd799439011",
  "user": {
    "id": "507f1f77bcf86cd799439011",
    "email": "user@example.com",
    "name": "John Doe"
  }
}
```

**POST /api/auth/login**
Login user.

Request:
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

Response: Same as register

#### Users (`/api/users`) - Protected

**GET /api/users**
Get all users.

**GET /api/users/:id**
Get user by ID.

**GET /api/users/:id/stats**
Get user statistics.

Response:
```json
{
  "workoutsCompleted": 25,
  "activeDays": 15,
  "totalCalories": 5000
}
```

**PATCH /api/users/:id**
Update user profile.

Request:
```json
{
  "name": "Updated Name",
  "profileImage": "https://..."
}
```

**DELETE /api/users/:id**
Delete user.

#### Workouts (`/api/workouts`) - Protected

**GET /api/workouts**
Get all workouts.

Query parameters:
- `category` (optional) - Filter by category (e.g., "Strength", "Cardio")

Response:
```json
{
  "data": [
    {
      "_id": "507f1f77bcf86cd799439011",
      "title": "Morning Workout",
      "description": "Full body workout",
      "category": "Strength",
      "duration": 45,
      "exercises": 8,
      "calories": 350,
      "isCompleted": false
    }
  ]
}
```

**GET /api/workouts/:id**
Get workout by ID.

**POST /api/workouts**
Create new workout.

Request:
```json
{
  "title": "Evening Run",
  "description": "Cardio workout",
  "category": "Cardio",
  "duration": 30,
  "exercises": 1,
  "calories": 250
}
```

**PATCH /api/workouts/:id**
Update workout.

**PATCH /api/workouts/:id/complete**
Mark workout as completed.

**DELETE /api/workouts/:id**
Delete workout.

#### Exercises (`/api/exercises`) - Protected

**GET /api/exercises**
Get all exercises.

Query parameters:
- `category` (optional) - Filter by category
- `difficulty` (optional) - Filter by difficulty (Beginner, Intermediate, Advanced)
- `search` (optional) - Search by name or description

Response:
```json
{
  "data": [
    {
      "_id": "507f1f77bcf86cd799439011",
      "name": "Push-ups",
      "description": "Classic upper body exercise",
      "category": "Strength",
      "difficulty": "Beginner",
      "sets": 3,
      "reps": 10
    }
  ]
}
```

**GET /api/exercises/:id**
Get exercise by ID.

**POST /api/exercises**
Create new exercise.

Request:
```json
{
  "name": "Squats",
  "description": "Lower body exercise",
  "category": "Strength",
  "difficulty": "Beginner",
  "sets": 3,
  "reps": 12
}
```

**PATCH /api/exercises/:id**
Update exercise.

**DELETE /api/exercises/:id**
Delete exercise.

## Integration Guide

### 1. Setup Flutter App

Add dependencies to `pubspec.yaml`:
```yaml
dependencies:
  http: ^1.1.0
  shared_preferences: ^2.2.2
```

Run:
```bash
flutter pub get
```

### 2. Configure API Endpoint

Update `lib/config/api_config.dart` with your API URL:
```dart
static const String baseUrl = 'https://your-api-domain.com/api';
```

### 3. Initialize Auth Service

In your main.dart or app initialization:
```dart
final authService = AuthService();
await authService.initialize();
```

### 4. Use Services in Your App

Example in a login screen:
```dart
Future<void> _handleLogin() async {
  final authService = AuthService();
  
  try {
    final response = await authService.login(
      _emailController.text,
      _passwordController.text,
    );
    
    // Navigate to home screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  } catch (e) {
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login failed: $e')),
    );
  }
}
```

## Error Handling

All services throw exceptions with descriptive messages. Wrap service calls in try-catch blocks:

```dart
try {
  final workouts = await workoutService.getWorkouts();
} catch (e) {
  print('Error: $e');
  // Handle error (show message to user, etc.)
}
```

## Security Notes

1. **Never commit API secrets** - Keep JWT_SECRET secure
2. **Use HTTPS in production** - Update API URL to use https://
3. **Validate all inputs** - Both client and server side
4. **Token expiration** - JWT tokens expire after 7 days
5. **CORS** - Configure CORS for your production domain

## Deployment

### Backend (NestJS)
1. Set up MongoDB instance (MongoDB Atlas recommended)
2. Configure environment variables
3. Deploy to hosting service (Heroku, AWS, DigitalOcean, etc.)
4. Update API URL in Flutter app

### Flutter App
1. Update API URL in `api_config.dart`
2. Build for production: `flutter build apk` or `flutter build ios`
3. Deploy to app stores

## Support

For issues or questions, please create an issue in the GitHub repository.
