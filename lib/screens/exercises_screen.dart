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
        return const Color(0xFFE31E24);
      default:
        return const Color(0xFF666666);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredExercises;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: const Text(
          'EXERCISE LIBRARY',
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
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(15),
            color: const Color(0xFF1A1A1A),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'SEARCH EXERCISES...',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF3A3A3A)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE31E24), width: 2),
                ),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFE31E24)),
              ),
            ),
          ),

          // Category Tabs
          Container(
            color: const Color(0xFF1A1A1A),
            padding: const EdgeInsets.symmetric(vertical: 10),
            height: 60,
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
                    label: Text(category.toUpperCase()),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    backgroundColor: const Color(0xFF2A2A2A),
                    selectedColor: const Color(0xFFE31E24),
                    side: BorderSide(
                      color: isSelected ? const Color(0xFFE31E24) : const Color(0xFF3A3A3A),
                      width: 2,
                    ),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),

          // Results Count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: const Color(0xFF1A1A1A),
            alignment: Alignment.centerLeft,
            child: Text(
              '${filtered.length} EXERCISE${filtered.length != 1 ? 'S' : ''} FOUND',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),

          // Exercise List
          Expanded(
            child: Container(
              color: const Color(0xFF1A1A1A),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final exercise = filtered[index];
                  return _buildExerciseCard(exercise);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(Map<String, dynamic> exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3A3A3A),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
                  exercise['name'].toString().toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: getDifficultyColor(exercise['difficulty']),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  exercise['difficulty'].toString().toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              const Text(
                'CATEGORY:',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white54,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                exercise['category'].toString().toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Row(
            children: [
              const Text(
                'RECOMMENDED:',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white54,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                exercise['sets'],
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 14),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE31E24),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                '+ ADD TO WORKOUT',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
