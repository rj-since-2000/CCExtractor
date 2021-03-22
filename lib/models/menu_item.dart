import 'package:flutter/material.dart';

class MenuItem {
  final int id;
  final String title;
  final IconData icon;
  final Function onClick;
  bool isSelected;
  MenuItem(this.id, this.title, this.icon, this.onClick,
      [this.isSelected = false]);
}
