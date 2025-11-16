# Quick Start Guide

This guide will help you quickly set up and run the Jess Fitness app with the backend API.

## Prerequisites

Before you begin, make sure you have:
- Flutter SDK (3.0.0 or higher)
- Node.js (v18 or higher)
- MongoDB (local installation or MongoDB Atlas account)
- A code editor (VS Code recommended)

## Step 1: Clone the Repository

```bash
git clone https://github.com/somkheartk/jess-fitness.git
cd jess-fitness
```

## Step 2: Set Up the Backend API

### Install Dependencies
```bash
cd backend
npm install
```

### Configure Environment
```bash
cp .env.example .env
```

Edit `.env` file with your configuration:
```env
PORT=3000
MONGODB_URI=mongodb://localhost:27017/jess-fitness
JWT_SECRET=your-super-secret-key-change-this
JWT_EXPIRATION=7d
```

**Important:** 
- If using MongoDB Atlas, replace `MONGODB_URI` with your connection string
- Change `JWT_SECRET` to a secure random string

### Start the Backend Server

Development mode (with auto-reload):
```bash
npm run start:dev
```

Or build and run in production mode:
```bash
npm run build
npm start
```

You should see:
```
🚀 Jess Fitness API is running on: http://localhost:3000
📚 API endpoints available at: http://localhost:3000/api
```

### Test the API

Test the health of the API by registering a user:
```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123",
    "name": "Test User"
  }'
```

You should receive a response with a JWT token.

## Step 3: Set Up the Flutter App

### Install Dependencies
```bash
cd ..  # Back to root directory
flutter pub get
```

### Configure API Endpoint

Edit `lib/config/api_config.dart`:

For local development:
```dart
static const String baseUrl = 'http://localhost:3000/api';
```

For Android emulator (if backend is on your machine):
```dart
static const String baseUrl = 'http://10.0.2.2:3000/api';
```

For iOS simulator (if backend is on your machine):
```dart
static const String baseUrl = 'http://localhost:3000/api';
```

For physical device (replace with your machine's IP):
```dart
static const String baseUrl = 'http://192.168.1.XXX:3000/api';
```

### Run the Flutter App

Connect a device or start an emulator, then run:
```bash
flutter run
```

## Step 4: Using the App

1. **Register**: Create a new account using the registration form
2. **Login**: Sign in with your credentials
3. **Explore**: Navigate through the app using the bottom navigation bar
   - Home: View your stats and workout categories
   - Workout: See your workout plans
   - Exercises: Browse the exercise library
   - Profile: View your profile and progress

## Troubleshooting

### Backend Issues

**MongoDB Connection Failed**
- Ensure MongoDB is running: `mongod`
- Check your `MONGODB_URI` in `.env`
- For MongoDB Atlas, check your IP whitelist and credentials

**Port Already in Use**
- Change the `PORT` in `.env` file
- Kill the process using port 3000: `lsof -ti:3000 | xargs kill -9` (Mac/Linux)

### Flutter App Issues

**Cannot Connect to API**
- Verify the backend is running
- Check the `baseUrl` in `api_config.dart`
- For Android emulator, use `10.0.2.2` instead of `localhost`
- Ensure your firewall allows connections

**Flutter Build Errors**
- Run `flutter clean`
- Run `flutter pub get`
- Restart your IDE

## Next Steps

1. **Create Test Data**: Use the API endpoints to create workouts and exercises
2. **Customize**: Modify the app's theme, colors, and features
3. **Deploy**: 
   - Backend: Deploy to Heroku, AWS, or DigitalOcean
   - Flutter: Build and publish to app stores

## API Endpoints Reference

See [API_DOCUMENTATION.md](API_DOCUMENTATION.md) for complete API reference.

Quick reference:
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `GET /api/workouts` - Get workouts (requires auth)
- `GET /api/exercises` - Get exercises (requires auth)
- `GET /api/users/:id` - Get user profile (requires auth)

## Development Tips

### Backend Development
- Use `npm run start:dev` for auto-reload during development
- MongoDB Compass is useful for viewing database contents
- Test endpoints with Postman or curl

### Flutter Development
- Use hot reload (press 'r' in terminal or click lightning icon)
- Use Flutter DevTools for debugging
- Test on both iOS and Android

## Support

For detailed documentation:
- Backend API: See [backend/README.md](backend/README.md)
- API Integration: See [API_DOCUMENTATION.md](API_DOCUMENTATION.md)
- Flutter App: See [README.md](README.md)

For issues or questions, create an issue on GitHub.
