import 'package:flutter/material.dart';
import 'answer_button.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'What is 2 + 2?',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          AnswerButton(answerText: '3', onTap: () {}),
          AnswerButton(answerText: '4', onTap: () {}),
          AnswerButton(answerText: '5', onTap: () {}),
        ],
      ),
    );
  }
}
