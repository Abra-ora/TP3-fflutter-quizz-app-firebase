part of 'quizz_questions_bloc.dart';

@immutable
abstract class QuizzQuestionsState {}

class QuizzQuestionsInitial extends QuizzQuestionsState {
  final List<QuestionModel> questions = [];
}


class QuestionLoading extends QuizzQuestionsState {
  final List<QuestionModel> questions = [];
}

class QuestionLoaded extends QuizzQuestionsState {
  final List<QuestionModel> questions;
  QuestionLoaded(this.questions);
}

class ToNextQuestion extends QuizzQuestionsState {
  final List<QuestionModel> questions;
  final int questionIndex;
  final int score;
  final List<Icon> scoreKeeper;
  ToNextQuestion(this.questionIndex, this.score, this.scoreKeeper, this.questions);
}

class QuestionLoadingError extends QuizzQuestionsState {
  final String error;
  QuestionLoadingError(this.error);
}

class QuizzFinished extends QuizzQuestionsState {
  final int score;
  QuizzFinished(this.score);
}