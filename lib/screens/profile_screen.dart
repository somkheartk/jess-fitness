import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6200EE),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              color: const Color(0xFF6200EE),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '👤',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Fitness Enthusiast',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Member since January 2024',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Stats Grid
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(child: _buildStatCard('150', 'Total Workouts')),
                  Expanded(child: _buildStatCard('112h', 'Time Trained')),
                  Expanded(child: _buildStatCard('52.5k', 'Calories Burned')),
                  Expanded(child: _buildStatCard('12 🔥', 'Day Streak')),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Goals Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Goals Progress',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildGoalCard('Workout 5 days/week', 80, 4, 5),
                  const SizedBox(height: 20),
                  _buildGoalCard('Burn 3000 cal/week', 65, 1950, 3000),
                  const SizedBox(height: 20),
                  _buildGoalCard('30-day streak', 40, 12, 30),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Achievements Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Achievements',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildAchievementCard('🏆', 'First Workout', true),
                      _buildAchievementCard('⭐', '100 Workouts', true),
                      _buildAchievementCard('🔥', '7-Day Streak', true),
                      _buildAchievementCard('💪', 'Iron Will', false),
                      _buildAchievementCard('🎯', 'Goal Master', false),
                      _buildAchievementCard('👑', 'Fitness King', false),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Settings Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildSettingItem('Edit Profile'),
                  _buildSettingItem('Notifications'),
                  _buildSettingItem('Units & Preferences'),
                  _buildSettingItem('Help & Support'),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6200EE),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(String name, int progress, int current, int target) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF333333),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$progress%',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6200EE),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress / 100,
            minHeight: 8,
            backgroundColor: const Color(0xFFE0E0E0),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6200EE)),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '$current / $target',
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(String icon, String name, bool unlocked) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  icon,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(height: 5),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
          if (!unlocked)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text('🔒', style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
          ),
          const Text(
            '›',
            style: TextStyle(fontSize: 24, color: Color(0xFF999999)),
          ),
        ],
      ),
    );
  }
}
