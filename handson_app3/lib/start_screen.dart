import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback startQuiz;

  StartScreen({required this.startQuiz});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/quiz_logo.png'),
          SizedBox(height: 20),
          Text(
            'Welcome to the Quiz!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          OutlinedButton(
            onPressed: startQuiz,
            child: Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}
