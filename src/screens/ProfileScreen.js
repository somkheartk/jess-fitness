import React from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity } from 'react-native';

export default function ProfileScreen() {
  const userStats = {
    name: 'Fitness Enthusiast',
    joinDate: 'January 2024',
    totalWorkouts: 150,
    totalMinutes: 6750,
    totalCalories: 52500,
    currentStreak: 12,
  };

  const goals = [
    { id: 1, name: 'Workout 5 days/week', progress: 80, target: 5, current: 4 },
    { id: 2, name: 'Burn 3000 cal/week', progress: 65, target: 3000, current: 1950 },
    { id: 3, name: '30-day streak', progress: 40, target: 30, current: 12 },
  ];

  const achievements = [
    { id: 1, icon: '🏆', name: 'First Workout', unlocked: true },
    { id: 2, icon: '⭐', name: '100 Workouts', unlocked: true },
    { id: 3, icon: '🔥', name: '7-Day Streak', unlocked: true },
    { id: 4, icon: '💪', name: 'Iron Will', unlocked: false },
    { id: 5, icon: '🎯', name: 'Goal Master', unlocked: false },
    { id: 6, icon: '👑', name: 'Fitness King', unlocked: false },
  ];

  return (
    <ScrollView style={styles.container}>
      <View style={styles.profileHeader}>
        <View style={styles.avatar}>
          <Text style={styles.avatarText}>👤</Text>
        </View>
        <Text style={styles.userName}>{userStats.name}</Text>
        <Text style={styles.joinDate}>Member since {userStats.joinDate}</Text>
      </View>

      <View style={styles.statsGrid}>
        <View style={styles.statCard}>
          <Text style={styles.statNumber}>{userStats.totalWorkouts}</Text>
          <Text style={styles.statLabel}>Total Workouts</Text>
        </View>
        <View style={styles.statCard}>
          <Text style={styles.statNumber}>{Math.floor(userStats.totalMinutes / 60)}h</Text>
          <Text style={styles.statLabel}>Time Trained</Text>
        </View>
        <View style={styles.statCard}>
          <Text style={styles.statNumber}>{(userStats.totalCalories / 1000).toFixed(1)}k</Text>
          <Text style={styles.statLabel}>Calories Burned</Text>
        </View>
        <View style={styles.statCard}>
          <Text style={styles.statNumber}>{userStats.currentStreak} 🔥</Text>
          <Text style={styles.statLabel}>Day Streak</Text>
        </View>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Goals Progress</Text>
        {goals.map((goal) => (
          <View key={goal.id} style={styles.goalCard}>
            <View style={styles.goalHeader}>
              <Text style={styles.goalName}>{goal.name}</Text>
              <Text style={styles.goalProgress}>{goal.progress}%</Text>
            </View>
            <View style={styles.progressBar}>
              <View style={[styles.progressFill, { width: `${goal.progress}%` }]} />
            </View>
            <Text style={styles.goalDetail}>
              {goal.current} / {goal.target}
            </Text>
          </View>
        ))}
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Achievements</Text>
        <View style={styles.achievementsGrid}>
          {achievements.map((achievement) => (
            <View
              key={achievement.id}
              style={[
                styles.achievementCard,
                !achievement.unlocked && styles.achievementLocked
              ]}
            >
              <Text style={styles.achievementIcon}>{achievement.icon}</Text>
              <Text style={styles.achievementName}>{achievement.name}</Text>
              {!achievement.unlocked && (
                <View style={styles.lockedOverlay}>
                  <Text style={styles.lockedText}>🔒</Text>
                </View>
              )}
            </View>
          ))}
        </View>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Settings</Text>
        <TouchableOpacity style={styles.settingItem}>
          <Text style={styles.settingText}>Edit Profile</Text>
          <Text style={styles.settingArrow}>›</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.settingItem}>
          <Text style={styles.settingText}>Notifications</Text>
          <Text style={styles.settingArrow}>›</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.settingItem}>
          <Text style={styles.settingText}>Units & Preferences</Text>
          <Text style={styles.settingArrow}>›</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.settingItem}>
          <Text style={styles.settingText}>Help & Support</Text>
          <Text style={styles.settingArrow}>›</Text>
        </TouchableOpacity>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },
  profileHeader: {
    backgroundColor: '#6200ee',
    padding: 30,
    alignItems: 'center',
  },
  avatar: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#fff',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 15,
  },
  avatarText: {
    fontSize: 40,
  },
  userName: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#fff',
    marginBottom: 5,
  },
  joinDate: {
    fontSize: 14,
    color: '#fff',
    opacity: 0.8,
  },
  statsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    padding: 10,
    backgroundColor: '#fff',
    marginBottom: 10,
  },
  statCard: {
    width: '50%',
    padding: 15,
    alignItems: 'center',
  },
  statNumber: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#6200ee',
  },
  statLabel: {
    fontSize: 14,
    color: '#666',
    marginTop: 5,
  },
  section: {
    backgroundColor: '#fff',
    padding: 20,
    marginBottom: 10,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 15,
  },
  goalCard: {
    marginBottom: 20,
  },
  goalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  goalName: {
    fontSize: 16,
    color: '#333',
    fontWeight: '600',
  },
  goalProgress: {
    fontSize: 16,
    color: '#6200ee',
    fontWeight: 'bold',
  },
  progressBar: {
    height: 8,
    backgroundColor: '#E0E0E0',
    borderRadius: 4,
    overflow: 'hidden',
    marginBottom: 5,
  },
  progressFill: {
    height: '100%',
    backgroundColor: '#6200ee',
  },
  goalDetail: {
    fontSize: 12,
    color: '#666',
  },
  achievementsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  achievementCard: {
    width: '30%',
    aspectRatio: 1,
    backgroundColor: '#F5F5F5',
    borderRadius: 10,
    padding: 10,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 10,
    position: 'relative',
  },
  achievementLocked: {
    opacity: 0.4,
  },
  achievementIcon: {
    fontSize: 32,
    marginBottom: 5,
  },
  achievementName: {
    fontSize: 11,
    color: '#333',
    textAlign: 'center',
  },
  lockedOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    justifyContent: 'center',
    alignItems: 'center',
  },
  lockedText: {
    fontSize: 24,
  },
  settingItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 15,
    borderBottomWidth: 1,
    borderBottomColor: '#F0F0F0',
  },
  settingText: {
    fontSize: 16,
    color: '#333',
  },
  settingArrow: {
    fontSize: 24,
    color: '#999',
  },
});
