import React from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity } from 'react-native';

export default function HomeScreen({ navigation }) {
  const categories = [
    { id: 1, name: 'Strength Training', color: '#FF6B6B', workouts: 12 },
    { id: 2, name: 'Cardio', color: '#4ECDC4', workouts: 8 },
    { id: 3, name: 'Flexibility', color: '#45B7D1', workouts: 6 },
    { id: 4, name: 'HIIT', color: '#FFA07A', workouts: 10 },
    { id: 5, name: 'Yoga', color: '#98D8C8', workouts: 7 },
    { id: 6, name: 'Pilates', color: '#F7B731', workouts: 5 },
  ];

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.welcomeText}>Welcome to Jess Fitness! 💪</Text>
        <Text style={styles.subText}>Choose your workout category</Text>
      </View>

      <View style={styles.statsContainer}>
        <View style={styles.statBox}>
          <Text style={styles.statNumber}>150</Text>
          <Text style={styles.statLabel}>Workouts</Text>
        </View>
        <View style={styles.statBox}>
          <Text style={styles.statNumber}>45</Text>
          <Text style={styles.statLabel}>Days Active</Text>
        </View>
        <View style={styles.statBox}>
          <Text style={styles.statNumber}>12.5k</Text>
          <Text style={styles.statLabel}>Calories</Text>
        </View>
      </View>

      <Text style={styles.sectionTitle}>Workout Categories</Text>
      
      <View style={styles.categoriesContainer}>
        {categories.map((category) => (
          <TouchableOpacity
            key={category.id}
            style={[styles.categoryCard, { backgroundColor: category.color }]}
            onPress={() => navigation.navigate('Workout')}
          >
            <Text style={styles.categoryName}>{category.name}</Text>
            <Text style={styles.categoryWorkouts}>{category.workouts} workouts</Text>
          </TouchableOpacity>
        ))}
      </View>
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
    marginBottom: 10,
  },
  welcomeText: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 5,
  },
  subText: {
    fontSize: 16,
    color: '#666',
  },
  statsContainer: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    backgroundColor: '#fff',
    padding: 20,
    marginBottom: 10,
  },
  statBox: {
    alignItems: 'center',
  },
  statNumber: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#6200ee',
  },
  statLabel: {
    fontSize: 14,
    color: '#666',
    marginTop: 5,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
    padding: 20,
    paddingBottom: 10,
  },
  categoriesContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    padding: 10,
    justifyContent: 'space-between',
  },
  categoryCard: {
    width: '48%',
    padding: 20,
    borderRadius: 15,
    marginBottom: 15,
    elevation: 3,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
  },
  categoryName: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#fff',
    marginBottom: 5,
  },
  categoryWorkouts: {
    fontSize: 14,
    color: '#fff',
    opacity: 0.9,
  },
});
