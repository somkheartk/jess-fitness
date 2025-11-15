import 'package:flutter/material.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  String searchQuery = '';
  String selectedCategory = 'All';

  final List<String> categories = ['All', 'Strength', 'Cardio', 'Flexibility', 'Core'];

  final List<Map<String, dynamic>> exercises = [
    {'id': 1, 'name': 'Push-ups', 'category': 'Strength', 'difficulty': 'Beginner', 'sets': '3x15'},
    {'id': 2, 'name': 'Squats', 'category': 'Strength', 'difficulty': 'Beginner', 'sets': '4x12'},
    {'id': 3, 'name': 'Running', 'category': 'Cardio', 'difficulty': 'Intermediate', 'sets': '30 min'},
    {'id': 4, 'name': 'Plank', 'category': 'Core', 'difficulty': 'Beginner', 'sets': '3x60s'},
    {'id': 5, 'name': 'Burpees', 'category': 'Cardio', 'difficulty': 'Advanced', 'sets': '3x10'},
    {'id': 6, 'name': 'Yoga Flow', 'category': 'Flexibility', 'difficulty': 'Intermediate', 'sets': '20 min'},
    {'id': 7, 'name': 'Deadlifts', 'category': 'Strength', 'difficulty': 'Advanced', 'sets': '4x8'},
    {'id': 8, 'name': 'Mountain Climbers', 'category': 'Cardio', 'difficulty': 'Intermediate', 'sets': '3x20'},
    {'id': 9, 'name': 'Bicycle Crunches', 'category': 'Core', 'difficulty': 'Beginner', 'sets': '3x20'},
    {'id': 10, 'name': 'Lunges', 'category': 'Strength', 'difficulty': 'Beginner', 'sets': '3x12'},
  ];

  List<Map<String, dynamic>> get filteredExercises {
    return exercises.where((exercise) {
      final matchesSearch = exercise['name']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      final matchesCategory =
          selectedCategory == 'All' || exercise['category'] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Color getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return const Color(0xFF4CAF50);
      case 'Intermediate':
        return const Color(0xFFFF9800);
      case 'Advanced':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF666666);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredExercises;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exercise Library',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6200EE),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search exercises...',
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),

          // Category Tabs
          Container(
            color: Colors.white,
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    backgroundColor: const Color(0xFFF5F5F5),
                    selectedColor: const Color(0xFF6200EE),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF666666),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),

          // Results Count
          Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            child: Text(
              '${filtered.length} exercise${filtered.length != 1 ? 's' : ''} found',
              style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
            ),
          ),

          // Exercise List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final exercise = filtered[index];
                return _buildExerciseCard(exercise);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(Map<String, dynamic> exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
                  exercise['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: getDifficultyColor(exercise['difficulty']),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  exercise['difficulty'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 10),
          
          Row(
            children: [
              const Text(
                'Category:',
                style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),
              const SizedBox(width: 10),
              Text(
                exercise['category'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 5),
          
          Row(
            children: [
              const Text(
                'Recommended:',
                style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),
              const SizedBox(width: 10),
              Text(
                exercise['sets'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 10),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE3F2FD),
                foregroundColor: const Color(0xFF6200EE),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '+ Add to Workout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
