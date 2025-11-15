import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, TextInput } from 'react-native';

export default function ExercisesScreen() {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('All');

  const categories = ['All', 'Strength', 'Cardio', 'Flexibility', 'Core'];

  const exercises = [
    { id: 1, name: 'Push-ups', category: 'Strength', difficulty: 'Beginner', sets: '3x15' },
    { id: 2, name: 'Squats', category: 'Strength', difficulty: 'Beginner', sets: '4x12' },
    { id: 3, name: 'Running', category: 'Cardio', difficulty: 'Intermediate', sets: '30 min' },
    { id: 4, name: 'Plank', category: 'Core', difficulty: 'Beginner', sets: '3x60s' },
    { id: 5, name: 'Burpees', category: 'Cardio', difficulty: 'Advanced', sets: '3x10' },
    { id: 6, name: 'Yoga Flow', category: 'Flexibility', difficulty: 'Intermediate', sets: '20 min' },
    { id: 7, name: 'Deadlifts', category: 'Strength', difficulty: 'Advanced', sets: '4x8' },
    { id: 8, name: 'Mountain Climbers', category: 'Cardio', difficulty: 'Intermediate', sets: '3x20' },
    { id: 9, name: 'Bicycle Crunches', category: 'Core', difficulty: 'Beginner', sets: '3x20' },
    { id: 10, name: 'Lunges', category: 'Strength', difficulty: 'Beginner', sets: '3x12' },
  ];

  const filteredExercises = exercises.filter(exercise => {
    const matchesSearch = exercise.name.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesCategory = selectedCategory === 'All' || exercise.category === selectedCategory;
    return matchesSearch && matchesCategory;
  });

  const getDifficultyColor = (difficulty) => {
    switch (difficulty) {
      case 'Beginner': return '#4CAF50';
      case 'Intermediate': return '#FF9800';
      case 'Advanced': return '#F44336';
      default: return '#666';
    }
  };

  return (
    <View style={styles.container}>
      <View style={styles.searchContainer}>
        <TextInput
          style={styles.searchInput}
          placeholder="Search exercises..."
          value={searchQuery}
          onChangeText={setSearchQuery}
        />
      </View>

      <ScrollView 
        horizontal 
        showsHorizontalScrollIndicator={false}
        style={styles.categoriesScroll}
      >
        {categories.map((category) => (
          <TouchableOpacity
            key={category}
            style={[
              styles.categoryButton,
              selectedCategory === category && styles.categoryButtonActive
            ]}
            onPress={() => setSelectedCategory(category)}
          >
            <Text
              style={[
                styles.categoryButtonText,
                selectedCategory === category && styles.categoryButtonTextActive
              ]}
            >
              {category}
            </Text>
          </TouchableOpacity>
        ))}
      </ScrollView>

      <ScrollView style={styles.exercisesContainer}>
        <Text style={styles.resultsText}>
          {filteredExercises.length} exercise{filteredExercises.length !== 1 ? 's' : ''} found
        </Text>
        
        {filteredExercises.map((exercise) => (
          <TouchableOpacity key={exercise.id} style={styles.exerciseCard}>
            <View style={styles.exerciseHeader}>
              <Text style={styles.exerciseName}>{exercise.name}</Text>
              <View 
                style={[
                  styles.difficultyBadge,
                  { backgroundColor: getDifficultyColor(exercise.difficulty) }
                ]}
              >
                <Text style={styles.difficultyText}>{exercise.difficulty}</Text>
              </View>
            </View>
            
            <View style={styles.exerciseDetails}>
              <View style={styles.exerciseDetailItem}>
                <Text style={styles.detailLabel}>Category:</Text>
                <Text style={styles.detailValue}>{exercise.category}</Text>
              </View>
              <View style={styles.exerciseDetailItem}>
                <Text style={styles.detailLabel}>Recommended:</Text>
                <Text style={styles.detailValue}>{exercise.sets}</Text>
              </View>
            </View>

            <TouchableOpacity style={styles.addToWorkoutButton}>
              <Text style={styles.addToWorkoutText}>+ Add to Workout</Text>
            </TouchableOpacity>
          </TouchableOpacity>
        ))}
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },
  searchContainer: {
    padding: 15,
    backgroundColor: '#fff',
  },
  searchInput: {
    backgroundColor: '#F5F5F5',
    padding: 12,
    borderRadius: 10,
    fontSize: 16,
  },
  categoriesScroll: {
    backgroundColor: '#fff',
    paddingHorizontal: 15,
    paddingBottom: 15,
    maxHeight: 50,
  },
  categoryButton: {
    paddingHorizontal: 20,
    paddingVertical: 8,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    marginRight: 10,
  },
  categoryButtonActive: {
    backgroundColor: '#6200ee',
  },
  categoryButtonText: {
    color: '#666',
    fontWeight: '600',
  },
  categoryButtonTextActive: {
    color: '#fff',
  },
  exercisesContainer: {
    flex: 1,
    padding: 15,
  },
  resultsText: {
    fontSize: 14,
    color: '#666',
    marginBottom: 15,
  },
  exerciseCard: {
    backgroundColor: '#fff',
    borderRadius: 15,
    padding: 15,
    marginBottom: 15,
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
  },
  exerciseHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 10,
  },
  exerciseName: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    flex: 1,
  },
  difficultyBadge: {
    paddingHorizontal: 10,
    paddingVertical: 5,
    borderRadius: 12,
  },
  difficultyText: {
    color: '#fff',
    fontSize: 12,
    fontWeight: 'bold',
  },
  exerciseDetails: {
    marginBottom: 10,
  },
  exerciseDetailItem: {
    flexDirection: 'row',
    marginBottom: 5,
  },
  detailLabel: {
    fontSize: 14,
    color: '#666',
    width: 100,
  },
  detailValue: {
    fontSize: 14,
    color: '#333',
    fontWeight: '600',
  },
  addToWorkoutButton: {
    backgroundColor: '#E3F2FD',
    padding: 10,
    borderRadius: 8,
    alignItems: 'center',
    marginTop: 5,
  },
  addToWorkoutText: {
    color: '#6200ee',
    fontWeight: 'bold',
  },
});
