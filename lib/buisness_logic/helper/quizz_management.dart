import 'package:flutter/material.dart';
import 'package:quizz_app_with_firebase_db/buisness_logic/bloc/get_quiz_questions_bloc/quizz_questions_bloc.dart';

import '../../data/models/question_model.dart';

class QuizzManagement {
  int _currentIndex;
  int _score;
  List<Icon> _scoreKeeper;
  List<QuestionModel> _questions;

  int quizzerLength = 10;

  get currentIndex => _currentIndex;
  get score => _score;
  get scoreKeeper => _scoreKeeper;
  get questions => _questions;
  void setQuestions(List<QuestionModel> questions) {
    _questions = questions;
  }

  QuizzManagement(
      this._currentIndex, this._score, this._scoreKeeper, this._questions);

  getCurrentQuestion() {
    return _questions[_currentIndex];
  }

  indexLessThanLength() {
    return _currentIndex <= _questions.length - 1;
  }

  answerIsCorrect(bool answer) {
    return getCurrentQuestion().answer == answer;
  }

  nextIndex() {
    if (indexLessThanLength()) {
      _currentIndex++;
    }
  }

  addScore(bool answer) {
    if (answerIsCorrect(answer)) {
      _score += 10;
      print("score: $_score");
    }
  }

  reset() {
    _currentIndex = 0;
    _score = 0;
    _scoreKeeper = [];
  }

  addIconToScorKeeper(bool answer) {
    if (answerIsCorrect(answer)) {
      scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
    } else {
      scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
    }
  }
}
