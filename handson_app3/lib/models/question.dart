import 'package:handson_app3/models/category.dart';

class Question {
  final String id;
  final String text;
  final List<String> answers;
  final Category category;

  const Question({
    required this.id,
    required this.text,
    required this.answers,
    required this.category,
  });

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
