class ApiConstants {
  // Base URL - แก้ตามที่ backend ของคุณ
  static const String baseUrl = 'http://localhost:3000/api';
  // static const String baseUrl = 'https://your-api.com/api';

  // API Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile';

  static const String workouts = '/workouts';
  static const String workoutDetail = '/workouts/:id';
  static const String createWorkout = '/workouts';
  static const String updateWorkout = '/workouts/:id';
  static const String deleteWorkout = '/workouts/:id';
  static const String completeWorkout = '/workouts/:id/complete';

  static const String exercises = '/exercises';
  static const String exerciseDetail = '/exercises/:id';

  static const String progress = '/progress';
  static const String progressByDate = '/progress/:date';
  static const String weeklyProgress = '/progress/weekly';
  static const String monthlyProgress = '/progress/monthly';

  static const String goals = '/goals';
  static const String goalDetail = '/goals/:id';
  static const String createGoal = '/goals';
  static const String updateGoal = '/goals/:id';
  static const String deleteGoal = '/goals/:id';
  static const String completeGoal = '/goals/:id/complete';

  // Timeout
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
}

class AppConstants {
  // App Info
  static const String appName = 'Jess Fitness';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserData = 'user_data';
  static const String keyThemeMode = 'theme_mode';

  // Workout Categories
  static const List<String> workoutCategories = [
    'Full Body',
    'Upper Body',
    'Lower Body',
    'Cardio',
    'Strength',
    'Flexibility',
    'HIIT',
    'Yoga',
  ];

  // Difficulty Levels
  static const List<String> difficultyLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Expert',
  ];

  // Muscle Groups
  static const List<String> muscleGroups = [
    'Chest',
    'Back',
    'Shoulders',
    'Arms',
    'Legs',
    'Core',
    'Glutes',
    'Cardio',
  ];

  // Equipment Types
  static const List<String> equipmentTypes = [
    'None',
    'Dumbbells',
    'Barbell',
    'Resistance Bands',
    'Kettlebell',
    'Machine',
    'Cable',
    'Bodyweight',
  ];

  // Goal Types
  static const List<String> goalTypes = [
    'daily',
    'weekly',
    'monthly',
    'custom',
  ];

  // Unit Types
  static const List<String> unitTypes = [
    'minutes',
    'calories',
    'kg',
    'workouts',
    'steps',
    'hours',
  ];
}

class ValidationConstants {
  // Email validation
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  // Password requirements
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;

  // Name requirements
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  // Workout requirements
  static const int minWorkoutDuration = 1; // minutes
  static const int maxWorkoutDuration = 300; // minutes

  // Weight requirements (kg)
  static const double minWeight = 20.0;
  static const double maxWeight = 300.0;

  // Height requirements (cm)
  static const double minHeight = 100.0;
  static const double maxHeight = 250.0;
}
