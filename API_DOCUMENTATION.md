# API Documentation - Jess Fitness

## Base URL
```
http://localhost:3000/api
```

## Authentication

### Register
```http
POST /auth/register
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}

Response:
{
  "token": "jwt-token",
  "refresh_token": "refresh-token",
  "user": {
    "id": "user-id",
    "name": "John Doe",
    "email": "john@example.com",
    "created_at": "2024-01-01T00:00:00.000Z"
  }
}
```

### Login
```http
POST /auth/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "password123"
}

Response:
{
  "token": "jwt-token",
  "refresh_token": "refresh-token",
  "user": { ... }
}
```

### Logout
```http
POST /auth/logout
Authorization: Bearer {token}

Response:
{
  "message": "Logged out successfully"
}
```

### Refresh Token
```http
POST /auth/refresh
Content-Type: application/json

{
  "refresh_token": "refresh-token"
}

Response:
{
  "token": "new-jwt-token"
}
```

## User Profile

### Get Profile
```http
GET /user/profile
Authorization: Bearer {token}

Response:
{
  "id": "user-id",
  "name": "John Doe",
  "email": "john@example.com",
  "avatar_url": "https://...",
  "date_of_birth": "1990-01-01",
  "weight": 75.0,
  "height": 175.0,
  "gender": "male",
  "created_at": "2024-01-01T00:00:00.000Z",
  "updated_at": "2024-01-01T00:00:00.000Z"
}
```

### Update Profile
```http
PUT /user/profile
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "John Smith",
  "weight": 74.5,
  "height": 175.0
}

Response:
{
  "id": "user-id",
  "name": "John Smith",
  ...
}
```

## Workouts

### Get All Workouts
```http
GET /workouts?category=Full Body&difficulty=Intermediate&completed=false
Authorization: Bearer {token}

Response:
[
  {
    "id": "workout-id",
    "user_id": "user-id",
    "name": "Full Body Workout",
    "description": "Complete full body strength training",
    "duration_minutes": 30,
    "calories_burned": 250,
    "category": "Full Body",
    "difficulty": "Intermediate",
    "exercises": [ ... ],
    "scheduled_date": "2024-01-01T10:00:00.000Z",
    "is_completed": false,
    "created_at": "2024-01-01T00:00:00.000Z"
  }
]
```

### Get Workout by ID
```http
GET /workouts/:id
Authorization: Bearer {token}

Response:
{
  "id": "workout-id",
  "user_id": "user-id",
  "name": "Full Body Workout",
  "exercises": [
    {
      "id": "exercise-id",
      "name": "Overhead Press",
      "description": "Shoulder press with dumbbells",
      "reps": 16,
      "sets": 3,
      "muscle_group": "Shoulders",
      "equipment": "Dumbbells",
      "order": 1
    }
  ],
  ...
}
```

### Create Workout
```http
POST /workouts
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "Morning Cardio",
  "description": "Quick morning cardio session",
  "duration_minutes": 20,
  "calories_burned": 200,
  "category": "Cardio",
  "difficulty": "Beginner",
  "exercises": [ ... ],
  "scheduled_date": "2024-01-02T06:00:00.000Z"
}

Response:
{
  "id": "new-workout-id",
  ...
}
```

### Update Workout
```http
PUT /workouts/:id
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "Updated Workout Name",
  "duration_minutes": 35
}

Response:
{
  "id": "workout-id",
  ...
}
```

### Delete Workout
```http
DELETE /workouts/:id
Authorization: Bearer {token}

Response:
{
  "message": "Workout deleted successfully"
}
```

### Complete Workout
```http
POST /workouts/:id/complete
Authorization: Bearer {token}

Response:
{
  "id": "workout-id",
  "is_completed": true,
  "completed_at": "2024-01-01T10:30:00.000Z",
  ...
}
```

## Exercises

### Get All Exercises
```http
GET /exercises?muscle_group=Chest&equipment=Dumbbells
Authorization: Bearer {token}

Response:
[
  {
    "id": "exercise-id",
    "name": "Dumbbell Press",
    "description": "Chest press with dumbbells",
    "reps": 12,
    "sets": 3,
    "muscle_group": "Chest",
    "equipment": "Dumbbells",
    "image_url": "https://...",
    "video_url": "https://..."
  }
]
```

### Get Exercise by ID
```http
GET /exercises/:id
Authorization: Bearer {token}

Response:
{
  "id": "exercise-id",
  ...
}
```

## Progress

### Get Progress Records
```http
GET /progress?start_date=2024-01-01&end_date=2024-01-07
Authorization: Bearer {token}

Response:
[
  {
    "id": "progress-id",
    "user_id": "user-id",
    "date": "2024-01-01",
    "weight": 75.0,
    "steps": 5000,
    "calories_burned": 250.0,
    "water_intake": 2000,
    "sleep_hours": 7.5,
    "workouts_completed": 1,
    "created_at": "2024-01-01T00:00:00.000Z"
  }
]
```

### Get Progress by Date
```http
GET /progress/:date
Authorization: Bearer {token}

Example: GET /progress/2024-01-01

Response:
{
  "id": "progress-id",
  "date": "2024-01-01",
  ...
}
```

### Get Weekly Progress
```http
GET /progress/weekly
Authorization: Bearer {token}

Response:
{
  "daily_progress": [ ... ],
  "average_calories": 245.5,
  "total_steps": 35000,
  "average_sleep_hours": 7.5,
  "total_workouts": 5
}
```

### Get Monthly Progress
```http
GET /progress/monthly?year=2024&month=1
Authorization: Bearer {token}

Response:
[ ... ]
```

### Save Progress
```http
POST /progress
Authorization: Bearer {token}
Content-Type: application/json

{
  "date": "2024-01-01",
  "weight": 75.0,
  "steps": 5000,
  "calories_burned": 250.0,
  "water_intake": 2000,
  "sleep_hours": 7.5,
  "workouts_completed": 1
}

Response:
{
  "id": "progress-id",
  ...
}
```

### Update Progress
```http
PATCH /progress/:id
Authorization: Bearer {token}
Content-Type: application/json

{
  "steps": 6000,
  "water_intake": 2500
}

Response:
{
  "id": "progress-id",
  ...
}
```

## Goals

### Get All Goals
```http
GET /goals?type=daily&is_completed=false&is_active=true
Authorization: Bearer {token}

Response:
[
  {
    "id": "goal-id",
    "user_id": "user-id",
    "name": "Running",
    "description": "Morning run in the park",
    "type": "daily",
    "target_value": 30,
    "current_value": 22,
    "unit": "minutes",
    "start_date": "2024-01-01",
    "end_date": "2024-01-01",
    "is_completed": false,
    "created_at": "2024-01-01T00:00:00.000Z"
  }
]
```

### Get Goal by ID
```http
GET /goals/:id
Authorization: Bearer {token}

Response:
{
  "id": "goal-id",
  ...
}
```

### Create Goal
```http
POST /goals
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "Weekly Workouts",
  "description": "Complete 5 workouts this week",
  "type": "weekly",
  "target_value": 5,
  "current_value": 0,
  "unit": "workouts",
  "start_date": "2024-01-01",
  "end_date": "2024-01-07"
}

Response:
{
  "id": "new-goal-id",
  ...
}
```

### Update Goal
```http
PUT /goals/:id
Authorization: Bearer {token}
Content-Type: application/json

{
  "current_value": 3
}

Response:
{
  "id": "goal-id",
  ...
}
```

### Update Goal Progress
```http
PATCH /goals/:id
Authorization: Bearer {token}
Content-Type: application/json

{
  "current_value": 25
}

Response:
{
  "id": "goal-id",
  "current_value": 25,
  ...
}
```

### Delete Goal
```http
DELETE /goals/:id
Authorization: Bearer {token}

Response:
{
  "message": "Goal deleted successfully"
}
```

### Complete Goal
```http
POST /goals/:id/complete
Authorization: Bearer {token}

Response:
{
  "id": "goal-id",
  "is_completed": true,
  "completed_at": "2024-01-01T10:30:00.000Z",
  ...
}
```

## Error Responses

### 400 Bad Request
```json
{
  "message": "Validation error",
  "errors": {
    "email": "Email is required",
    "password": "Password must be at least 6 characters"
  }
}
```

### 401 Unauthorized
```json
{
  "message": "Invalid credentials"
}
```

### 404 Not Found
```json
{
  "message": "Resource not found"
}
```

### 500 Internal Server Error
```json
{
  "message": "Internal server error"
}
```

## Notes

- All dates should be in ISO 8601 format
- Authentication required for all endpoints except `/auth/login` and `/auth/register`
- Token expires in 24 hours
- Use refresh token to get a new access token
- All numeric values (weight, height, calories, etc.) should be numbers, not strings
