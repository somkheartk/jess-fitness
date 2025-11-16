import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: const Text(
          'JESS FITNESS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Red Accent
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFE31E24),
                    const Color(0xFFE31E24).withOpacity(0.8),
                  ],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UNLEASH YOUR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    'POTENTIAL',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Choose your workout category',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Stats Section - Dark Cards
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: const Color(0xFF1A1A1A),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatBox('247', 'Workouts'),
                  _buildStatBox('89', 'Days Active'),
                  _buildStatBox('18.2k', 'Calories'),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Categories Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'WORKOUT CATEGORIES',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Category Cards with Bold Design
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  _buildCategoryCard('STRENGTH', '18 workouts', const Color(0xFFE31E24)),
                  _buildCategoryCard('CARDIO', '15 workouts', const Color(0xFF2A2A2A)),
                  _buildCategoryCard('FLEXIBILITY', '10 workouts', const Color(0xFFE31E24)),
                  _buildCategoryCard('HIIT', '14 workouts', const Color(0xFF2A2A2A)),
                  _buildCategoryCard('YOGA', '12 workouts', const Color(0xFFE31E24)),
                  _buildCategoryCard('PILATES', '8 workouts', const Color(0xFF2A2A2A)),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3A3A3A),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Color(0xFFE31E24),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String name, String workouts, Color color) {
    return Container(
      width: 165,
      height: 140,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color == const Color(0xFFE31E24) 
              ? const Color(0xFFE31E24) 
              : const Color(0xFF3A3A3A),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color == const Color(0xFFE31E24)
                ? const Color(0xFFE31E24).withOpacity(0.3)
                : Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 3,
                width: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                workouts.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
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
