import 'package:flutter/material.dart';

enum Categories {
  mobileProgramming,
  computerNetwork,
}

class Category {
  final String title;
  final Color color;

  const Category(this.title, this.color);
}
