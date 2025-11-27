import 'package:flutter/material.dart';

class ChoreType {
  final String title;
  final IconData icon;

  ChoreType({required this.title, required this.icon}); 
}

class ChoreHelper {
  static List<ChoreType> loadAvailableTypes() {
    return [
      ChoreType(title: 'Cleaning', icon: Icons.cleaning_services),
      ChoreType(title: 'Laundry', icon: Icons.local_laundry_service),
      ChoreType(title: 'Pets', icon: Icons.pets),
      ChoreType(title: 'School', icon: Icons.school),
      ChoreType(title: 'Fitness', icon: Icons.fitness_center),
      ChoreType(title: 'Shopping', icon: Icons.shopping_cart),
      ChoreType(title: 'Kitchen', icon: Icons.kitchen),
    ];
  }

  static List<int> loadAvailablePoints() {
    return [5, 10, 25, 50];
  }
}