import 'package:flutter/material.dart';
import 'dart:math';

import 'package:quizzler_app/quiz_brain.dart';

void main() => runApp(Quizzler());
QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = <Icon>[];

  @override
  Widget build(BuildContext context) {
    // Get screen dimension
    Size size = MediaQuery.of(context).size;
    if (isMaxScreenWidth(size)) {
      print("Max na");
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }

  void checkAnswer(bool userPicked) {
    setState(() {
      quizBrain.incrementQuestionCount();

      if(quizBrain.getQuestionAnswer() == userPicked) {
        scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            )
        );
        quizBrain.removeQuestion();
      } else {
        scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            )
        );
      }
    });
    quizBrain.setQuestionIndex(Random().nextInt(quizBrain.getQuestionsLength()));
  }

  bool isMaxScreenWidth(Size size) {
    double width = size.width;
    double iconHorizonalPixelMax = width / 24;
    int myDouble = iconHorizonalPixelMax.round() - 1;

    if (quizBrain.getQuestionCount() >= myDouble) {
      return true;
    }
    return false;
  }
}
