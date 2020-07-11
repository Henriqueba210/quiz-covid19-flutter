import 'package:flutter/material.dart';
import 'package:quiz_covid_19_fluter_henrique/components/AnswerButton.dart';
import 'package:quiz_covid_19_fluter_henrique/components/QuestionContainer.dart';
import 'package:quiz_covid_19_fluter_henrique/components/centered_circular_progress.dart';
import 'package:quiz_covid_19_fluter_henrique/components/centered_message.dart';
import 'package:quiz_covid_19_fluter_henrique/controllers/quiz_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _controller = QuizController();
  List<Widget> _scoreKeeper = [];
  final ScrollController _scrollController = ScrollController();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _controller.initialize();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text(
            'QUIZ COVID-19 ( ${_scoreKeeper.length}/${_controller.questionsNumber} )'),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildQuiz(),
        ),
      ),
    );
  }

  _buildQuiz() {
    if (_loading) return CenteredCircularProgress();

    if (_controller.questionsNumber == 0)
      return CenteredMessage('Sem questões',
          icon: FontAwesomeIcons.exclamationTriangle);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        QuestionContainer(_controller.getQuestion()),
        AnswerButton(_controller, _scoreKeeper, context,
            _controller.getAnswer1(), this, _scrollController),
        AnswerButton(_controller, _scoreKeeper, context,
            _controller.getAnswer2(), this, _scrollController),
        _buildScoreKeeper(),
      ],
    );
  }

  _buildScoreKeeper() {
    return Expanded(
        child: Center(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _scoreKeeper.length,
        controller: _scrollController,
        itemBuilder: (BuildContext, int) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Align(alignment: Alignment.center, child: _scoreKeeper[int]),
          );
        },
      ),
    ));
  }
}
