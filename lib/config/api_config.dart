class ApiConfig {
  // Base URL for the API - change this to your deployed API URL
  static const String baseUrl = 'http://localhost:3000/api';
  
  // API Endpoints
  static const String authEndpoint = '/auth';
  static const String usersEndpoint = '/users';
  static const String workoutsEndpoint = '/workouts';
  static const String exercisesEndpoint = '/exercises';
  
  // Timeout duration
  static const Duration timeoutDuration = Duration(seconds: 30);
}
