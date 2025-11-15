import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jess Fitness',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6200EE),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Jess Fitness! 💪',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Choose your workout category',
                    style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Stats Section
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatBox('150', 'Workouts'),
                  _buildStatBox('45', 'Days Active'),
                  _buildStatBox('12.5k', 'Calories'),
                ],
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Categories Section
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Workout Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            
            // Category Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  _buildCategoryCard('Strength Training', '12 workouts', const Color(0xFFFF6B6B)),
                  _buildCategoryCard('Cardio', '8 workouts', const Color(0xFF4ECDC4)),
                  _buildCategoryCard('Flexibility', '6 workouts', const Color(0xFF45B7D1)),
                  _buildCategoryCard('HIIT', '10 workouts', const Color(0xFFFFA07A)),
                  _buildCategoryCard('Yoga', '7 workouts', const Color(0xFF98D8C8)),
                  _buildCategoryCard('Pilates', '5 workouts', const Color(0xFFF7B731)),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6200EE),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String name, String workouts, Color color) {
    return Container(
      width: 165,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            workouts,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}
