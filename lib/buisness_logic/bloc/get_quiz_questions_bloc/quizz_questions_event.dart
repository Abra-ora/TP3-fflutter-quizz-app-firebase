part of 'quizz_questions_bloc.dart';

@immutable
abstract class QuestionFormEvent {}

class getQuizzQuestionsEvent extends QuestionFormEvent {
  List<QuestionModel> questions = [];
  getQuizzQuestionsEvent();
}

class ToNextQuestionEvent extends QuestionFormEvent {
  List<QuestionModel> questions;
  bool answer;

  ToNextQuestionEvent(this.questions, this.answer);
}

class QuizzFinishedEvent extends QuestionFormEvent {
  QuizzFinishedEvent();
}

class ResetQuizzEvent extends QuestionFormEvent {
  ResetQuizzEvent();
}