import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: const Text(
          'PROFILE',
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
          children: [
            // Profile Header - Red Gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
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
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        '💪',
                        style: TextStyle(fontSize: 45),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'FITNESS ENTHUSIAST',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'MEMBER SINCE AUGUST 2024',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),

            // Stats Grid - Dark Cards
            Container(
              padding: const EdgeInsets.all(12),
              color: const Color(0xFF1A1A1A),
              child: Row(
                children: [
                  Expanded(child: _buildStatCard('247', 'TOTAL\nWORKOUTS')),
                  Expanded(child: _buildStatCard('186H', 'TIME\nTRAINED')),
                  Expanded(child: _buildStatCard('78.3K', 'CALORIES\nBURNED')),
                  Expanded(child: _buildStatCard('21🔥', 'DAY\nSTREAK')),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Goals Section - Dark Theme
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: const Color(0xFF1A1A1A),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'GOALS PROGRESS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildGoalCard('WORKOUT 5 DAYS/WEEK', 100, 5, 5),
                  const SizedBox(height: 16),
                  _buildGoalCard('BURN 3500 CAL/WEEK', 78, 2730, 3500),
                  const SizedBox(height: 16),
                  _buildGoalCard('30-DAY STREAK', 70, 21, 30),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Achievements Section - Dark Theme
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: const Color(0xFF1A1A1A),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ACHIEVEMENTS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildAchievementCard('🏆', 'FIRST\nWORKOUT', true),
                      _buildAchievementCard('⭐', '100\nWORKOUTS', true),
                      _buildAchievementCard('🔥', '7-DAY\nSTREAK', true),
                      _buildAchievementCard('💪', 'IRON\nWILL', false),
                      _buildAchievementCard('🎯', 'GOAL\nMASTER', false),
                      _buildAchievementCard('👑', 'FITNESS\nKING', false),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Settings Section - Dark Theme
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: const Color(0xFF1A1A1A),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SETTINGS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem('EDIT PROFILE'),
                  _buildSettingItem('NOTIFICATIONS'),
                  _buildSettingItem('UNITS & PREFERENCES'),
                  _buildSettingItem('HELP & SUPPORT'),
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
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFFE31E24),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white70,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(String name, int progress, int current, int target) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3A3A3A),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Text(
                '$progress%',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFE31E24),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress / 100,
              minHeight: 10,
              backgroundColor: const Color(0xFF1A1A1A),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE31E24)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$current / $target',
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(String icon, String name, bool unlocked) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: unlocked ? const Color(0xFF2A2A2A) : const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: unlocked ? const Color(0xFFE31E24) : const Color(0xFF3A3A3A),
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  icon,
                  style: TextStyle(
                    fontSize: 32,
                    opacity: unlocked ? 1.0 : 0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    color: unlocked ? Colors.white : Colors.white30,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          if (!unlocked)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3A3A3A),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Color(0xFFE31E24),
          ),
        ],
      ),
    );
  }
}
