import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  List<Map<String, dynamic>> workouts = [
    {
      'id': 1,
      'name': 'Upper Body Blast',
      'duration': '45 min',
      'exercises': 8,
      'calories': 350,
      'completed': false,
    },
    {
      'id': 2,
      'name': 'Leg Day Power',
      'duration': '60 min',
      'exercises': 10,
      'calories': 450,
      'completed': true,
    },
    {
      'id': 3,
      'name': 'Core Strength',
      'duration': '30 min',
      'exercises': 6,
      'calories': 200,
      'completed': false,
    },
    {
      'id': 4,
      'name': 'Full Body Circuit',
      'duration': '50 min',
      'exercises': 12,
      'calories': 400,
      'completed': false,
    },
  ];

  void toggleWorkout(int id) {
    setState(() {
      final index = workouts.indexWhere((w) => w['id'] == id);
      if (index != -1) {
        workouts[index]['completed'] = !workouts[index]['completed'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Workouts',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6200EE),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Workout Plan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Track your fitness journey',
                    style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 15),
            
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                final workout = workouts[index];
                return _buildWorkoutCard(workout);
              },
            ),
            
            const SizedBox(height: 15),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xFF6200EE),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '+ Add Custom Workout',
                    style: TextStyle(
                      color: Color(0xFF6200EE),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(Map<String, dynamic> workout) {
    final bool isCompleted = workout['completed'];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: isCompleted
            ? Border.all(color: const Color(0xFF4CAF50), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  workout['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              if (isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '✓ Completed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 15),
          
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDetailItem('⏱️', workout['duration']),
                _buildDetailItem('💪', '${workout['exercises']} exercises'),
                _buildDetailItem('🔥', '${workout['calories']} cal'),
              ],
            ),
          ),
          
          const SizedBox(height: 15),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => toggleWorkout(workout['id']),
              style: ElevatedButton.styleFrom(
                backgroundColor: isCompleted
                    ? const Color(0xFFFF9800)
                    : const Color(0xFF6200EE),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                isCompleted ? 'Mark Incomplete' : 'Start Workout',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String icon, String text) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
        ),
      ],
    );
  }
}
