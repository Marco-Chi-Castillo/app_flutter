import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'home': Icons.home,
  'today': Icons.today,
  'people': Icons.people,
  'home_work': Icons.home_work,
  'home_filled': Icons.home_filled,
};

Icon getIcon(String nombreIcon) {
  return Icon(_icons[nombreIcon]);
}
