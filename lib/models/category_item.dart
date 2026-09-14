import 'package:flutter/material.dart';

class CategoryItem {
  final String id;
  final String name;
  final String icon;
  final String? description;
  final Color color;
  final String emoji;

  CategoryItem({
    required this.id,
    required this.name,
    required this.icon,
    this.description,
    this.color = Colors.blue,
    this.emoji = '🏪',
  });
}