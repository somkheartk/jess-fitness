import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'habit_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedDay = DateTime.now().day;
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Clean Header Section
              Container(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('EEEE').format(currentDate),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Hello John',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A1A),
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF7B61FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: Color(0xFF7B61FF),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24), // Calendar Week View
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          final date =
                              currentDate.subtract(Duration(days: 3 - index));
                          final day = date.day;
                          final isSelected = day == selectedDay;
                          final isToday = day == DateTime.now().day;
                          final dayName =
                              DateFormat('E').format(date).substring(0, 1);

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDay = day;
                              });
                            },
                            child: Container(
                              width: 48,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF1A1A1A)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: isToday && !isSelected
                                    ? Border.all(
                                        color: Colors.grey[300]!,
                                        width: 1,
                                      )
                                    : null,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    dayName,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isSelected
                                          ? Colors.white.withOpacity(0.7)
                                          : Colors.grey[500],
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '$day',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFF1A1A1A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Stats Overview
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMiniStat(
                          '14', 'Streak', Icons.local_fire_department),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey[200],
                      ),
                      _buildMiniStat('650', 'Calories',
                          Icons.local_fire_department_outlined),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey[200],
                      ),
                      _buildMiniStat('4.2k', 'Steps', Icons.directions_walk),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              const SizedBox(height: 0),

              // Habits
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Habits",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                        letterSpacing: -0.3,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '3 Active',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildHabitCard('Exercise', Icons.directions_bike,
                        const Color(0xFFFF6B6B), 3, 5),
                    const SizedBox(height: 12),
                    _buildHabitCard('Reading', Icons.menu_book,
                        const Color(0xFF7B61FF), 2, 7),
                    const SizedBox(height: 12),
                    _buildHabitCard('Meditation', Icons.self_improvement,
                        const Color(0xFFFF8A8A), 1, 3),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHabitCard(
      String title, IconData icon, Color color, int current, int target) {
    final progress = current / target;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HabitDetailScreen(
              habitName: title,
              icon: icon,
              color: color,
              current: current,
              target: target,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        '$current/$target',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: progress,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
