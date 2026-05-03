import 'package:flutter/material.dart';

class KpiItem {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color color;

  KpiItem({
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    required this.color,
  });
}
