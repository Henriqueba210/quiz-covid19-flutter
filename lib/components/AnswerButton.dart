import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_covid_19_fluter_henrique/components/result_dialog.dart';
import 'package:quiz_covid_19_fluter_henrique/controllers/quiz_controller.dart';
import 'package:quiz_covid_19_fluter_henrique/pages/quiz_page.dart';

import 'finish_dialog.dart';

class AnswerButton extends StatelessWidget {
  final QuizController controller;
  final List<Widget> scoreKeeper;
  final BuildContext context;
  final String answer;
  final State<QuizPage> quizPageState;

  AnswerButton(
   this.controller,
    this.scoreKeeper,
    this.context,
    this.answer,
    this.quizPageState
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          child: Container(
            padding: EdgeInsets.all(4.0),
            color: Colors.blue,
            child: Center(
              child: AutoSizeText(
                answer,
                maxLines: 2,
                minFontSize: 10.0,
                maxFontSize: 32.0,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          onTap: () {
            bool correct = controller.correctAnswer(answer);

            ResultDialog.show(
              context,
              question: controller.question,
              correct: correct,
              onNext: () {
                quizPageState.setState(() {
                  scoreKeeper.add(
                    Icon(
                      correct ? FontAwesomeIcons.check : FontAwesomeIcons.times,
                      color: correct ? Colors.green : Colors.red,
                    ),
                  );
                  if (scoreKeeper.length < controller.questionsNumber) {
                    controller.nextQuestion();
                  } else {
                    FinishDialog.show(
                      context,
                      hitNumber: controller.hitNumber,
                      questionNumber:  controller.questionsNumber
                    );
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }
}
