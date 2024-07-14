import 'package:handson_app3/data/categories.dart';
import 'package:handson_app3/models/category.dart';
import 'package:handson_app3/models/question.dart';

final questions = [
  Question(
      id: '1',
      text: 'Berikut ini yang bukan merupakan fungsi Layer Transport adalah...',
      answers: ['Routing', 'Segmentasi', 'Flow control', 'Error control'],
      category: categories[Categories.computerNetwork]!),
];