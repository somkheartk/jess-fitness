import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity } from 'react-native';

export default function WorkoutScreen() {
  const [activeWorkouts, setActiveWorkouts] = useState([
    {
      id: 1,
      name: 'Upper Body Blast',
      duration: '45 min',
      exercises: 8,
      calories: 350,
      completed: false,
    },
    {
      id: 2,
      name: 'Leg Day Power',
      duration: '60 min',
      exercises: 10,
      calories: 450,
      completed: true,
    },
    {
      id: 3,
      name: 'Core Strength',
      duration: '30 min',
      exercises: 6,
      calories: 200,
      completed: false,
    },
    {
      id: 4,
      name: 'Full Body Circuit',
      duration: '50 min',
      exercises: 12,
      calories: 400,
      completed: false,
    },
  ]);

  const toggleWorkout = (id) => {
    setActiveWorkouts(workouts =>
      workouts.map(workout =>
        workout.id === id ? { ...workout, completed: !workout.completed } : workout
      )
    );
  };

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>My Workout Plan</Text>
        <Text style={styles.subtitle}>Track your fitness journey</Text>
      </View>

      <View style={styles.workoutsContainer}>
        {activeWorkouts.map((workout) => (
          <TouchableOpacity
            key={workout.id}
            style={[
              styles.workoutCard,
              workout.completed && styles.workoutCardCompleted
            ]}
            onPress={() => toggleWorkout(workout.id)}
          >
            <View style={styles.workoutHeader}>
              <Text style={styles.workoutName}>{workout.name}</Text>
              {workout.completed && (
                <Text style={styles.completedBadge}>✓ Completed</Text>
              )}
            </View>
            
            <View style={styles.workoutDetails}>
              <View style={styles.detailItem}>
                <Text style={styles.detailIcon}>⏱️</Text>
                <Text style={styles.detailText}>{workout.duration}</Text>
              </View>
              <View style={styles.detailItem}>
                <Text style={styles.detailIcon}>💪</Text>
                <Text style={styles.detailText}>{workout.exercises} exercises</Text>
              </View>
              <View style={styles.detailItem}>
                <Text style={styles.detailIcon}>🔥</Text>
                <Text style={styles.detailText}>{workout.calories} cal</Text>
              </View>
            </View>

            <TouchableOpacity 
              style={[
                styles.startButton,
                workout.completed && styles.startButtonCompleted
              ]}
              onPress={() => toggleWorkout(workout.id)}
            >
              <Text style={styles.startButtonText}>
                {workout.completed ? 'Mark Incomplete' : 'Start Workout'}
              </Text>
            </TouchableOpacity>
          </TouchableOpacity>
        ))}
      </View>

      <TouchableOpacity style={styles.addButton}>
        <Text style={styles.addButtonText}>+ Add Custom Workout</Text>
      </TouchableOpacity>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },
  header: {
    padding: 20,
    backgroundColor: '#fff',
    marginBottom: 15,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 5,
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
  },
  workoutsContainer: {
    padding: 15,
  },
  workoutCard: {
    backgroundColor: '#fff',
    borderRadius: 15,
    padding: 20,
    marginBottom: 15,
    elevation: 3,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 3.84,
  },
  workoutCardCompleted: {
    backgroundColor: '#E8F5E9',
    borderColor: '#4CAF50',
    borderWidth: 2,
  },
  workoutHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 15,
  },
  workoutName: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
    flex: 1,
  },
  completedBadge: {
    backgroundColor: '#4CAF50',
    color: '#fff',
    paddingHorizontal: 10,
    paddingVertical: 5,
    borderRadius: 12,
    fontSize: 12,
    fontWeight: 'bold',
  },
  workoutDetails: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    marginBottom: 15,
    paddingVertical: 10,
    backgroundColor: '#F8F8F8',
    borderRadius: 10,
  },
  detailItem: {
    alignItems: 'center',
  },
  detailIcon: {
    fontSize: 20,
    marginBottom: 5,
  },
  detailText: {
    fontSize: 14,
    color: '#666',
  },
  startButton: {
    backgroundColor: '#6200ee',
    padding: 15,
    borderRadius: 10,
    alignItems: 'center',
  },
  startButtonCompleted: {
    backgroundColor: '#FF9800',
  },
  startButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
  addButton: {
    backgroundColor: '#fff',
    padding: 20,
    margin: 15,
    borderRadius: 15,
    alignItems: 'center',
    borderWidth: 2,
    borderColor: '#6200ee',
    borderStyle: 'dashed',
  },
  addButtonText: {
    color: '#6200ee',
    fontSize: 16,
    fontWeight: 'bold',
  },
});
