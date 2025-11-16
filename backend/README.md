# Jess Fitness API - NestJS + MongoDB

Backend API for the Jess Fitness mobile application.

## Tech Stack

- **NestJS** - Progressive Node.js framework
- **MongoDB** - NoSQL database
- **Mongoose** - MongoDB object modeling
- **JWT** - JSON Web Token authentication
- **Passport** - Authentication middleware
- **bcrypt** - Password hashing

## Features

- ✅ User authentication (register, login)
- ✅ JWT token-based authentication
- ✅ User management with profile and stats
- ✅ Workout CRUD operations
- ✅ Exercise library management
- ✅ Category and difficulty filtering
- ✅ CORS enabled for Flutter app

## Prerequisites

- Node.js (v18 or higher)
- MongoDB (local or cloud instance)
- npm or yarn

## Installation

1. Install dependencies:
```bash
npm install
```

2. Create `.env` file from example:
```bash
cp .env.example .env
```

3. Update `.env` with your configuration:
```env
PORT=3000
MONGODB_URI=mongodb://localhost:27017/jess-fitness
JWT_SECRET=your-secret-key-change-this-in-production
JWT_EXPIRATION=7d
```

## Running the API

### Development mode
```bash
npm run start:dev
```

### Production mode
```bash
npm run build
npm start
```

The API will be available at `http://localhost:3000`

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user

### Users (Protected)
- `GET /api/users` - Get all users
- `GET /api/users/:id` - Get user by ID
- `GET /api/users/:id/stats` - Get user statistics
- `PATCH /api/users/:id` - Update user profile
- `DELETE /api/users/:id` - Delete user

### Workouts (Protected)
- `GET /api/workouts` - Get all workouts (optional: ?category=Strength)
- `GET /api/workouts/:id` - Get workout by ID
- `POST /api/workouts` - Create new workout
- `PATCH /api/workouts/:id` - Update workout
- `PATCH /api/workouts/:id/complete` - Mark workout as completed
- `DELETE /api/workouts/:id` - Delete workout

### Exercises (Protected)
- `GET /api/exercises` - Get all exercises (optional: ?category=Strength&difficulty=Beginner&search=push)
- `GET /api/exercises/:id` - Get exercise by ID
- `POST /api/exercises` - Create new exercise
- `PATCH /api/exercises/:id` - Update exercise
- `DELETE /api/exercises/:id` - Delete exercise

## Authentication

Protected endpoints require JWT token in the Authorization header:
```
Authorization: Bearer <your-jwt-token>
```

## Example Requests

### Register
```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "password123",
    "name": "John Doe"
  }'
```

### Login
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "password123"
  }'
```

### Get Workouts (with token)
```bash
curl -X GET http://localhost:3000/api/workouts \
  -H "Authorization: Bearer <your-token>"
```

## Project Structure

```
backend/
├── src/
│   ├── auth/              # Authentication module
│   │   ├── dto/
│   │   ├── auth.controller.ts
│   │   ├── auth.service.ts
│   │   ├── auth.module.ts
│   │   ├── jwt.strategy.ts
│   │   └── jwt-auth.guard.ts
│   ├── users/             # Users module
│   │   ├── dto/
│   │   ├── user.schema.ts
│   │   ├── users.controller.ts
│   │   ├── users.service.ts
│   │   └── users.module.ts
│   ├── workouts/          # Workouts module
│   │   ├── dto/
│   │   ├── workout.schema.ts
│   │   ├── workouts.controller.ts
│   │   ├── workouts.service.ts
│   │   └── workouts.module.ts
│   ├── exercises/         # Exercises module
│   │   ├── dto/
│   │   ├── exercise.schema.ts
│   │   ├── exercises.controller.ts
│   │   ├── exercises.service.ts
│   │   └── exercises.module.ts
│   ├── app.module.ts      # Root module
│   └── main.ts            # Entry point
├── .env.example           # Environment variables example
├── tsconfig.json          # TypeScript configuration
└── package.json           # Dependencies
```

## Security

- Passwords are hashed using bcrypt
- JWT tokens expire after 7 days (configurable)
- CORS is enabled for all origins (configure for production)
- Input validation using class-validator

## License

ISC
