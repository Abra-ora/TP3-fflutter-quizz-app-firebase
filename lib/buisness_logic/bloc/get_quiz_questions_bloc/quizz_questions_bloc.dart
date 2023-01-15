import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:quizz_app_with_firebase_db/buisness_logic/helper/quizz_management.dart';
import 'package:quizz_app_with_firebase_db/data/repositories/questions_repository.dart';
import 'package:quizz_app_with_firebase_db/data/models/question_model.dart';

part 'quizz_questions_event.dart';
part 'quizz_questions_state.dart';

class QuizzQuestionsBloc extends Bloc<QuestionFormEvent, QuizzQuestionsState> {
  final QuestionsRepository questionsRepository;
  
  QuizzManagement quizzManagement = QuizzManagement(0, 0, [], []);

  QuizzQuestionsBloc({required this.questionsRepository})
      : super(QuizzQuestionsInitial()) {
    on<getQuizzQuestionsEvent>((event, emit) async {
      emit(QuestionLoading());
      try {
        List<QuestionModel> questions =
            await questionsRepository.fetchQuestions();
        emit(QuestionLoaded(questions));
      } catch (e) {
        emit(QuestionLoadingError(e.toString()));
      }
    });

    on<ToNextQuestionEvent>((event, emit) {
      if (quizzManagement.currentIndex < event.questions.length - 1 &&
          quizzManagement.currentIndex < quizzManagement.quizzerLength - 1) {
        quizzManagement.setQuestions(event.questions);
        quizzManagement.nextIndex();
        quizzManagement.addScore(event.answer);
        quizzManagement.addIconToScorKeeper(event.answer);
        emit(ToNextQuestion(quizzManagement.currentIndex, quizzManagement.score,
            quizzManagement.scoreKeeper, event.questions));
      } else {
        emit(QuizzFinished(quizzManagement.score));
      }
    });

    on<QuizzFinishedEvent>((event, emit) {
      emit(QuizzFinished(quizzManagement.score));
    });

    on<ResetQuizzEvent>((event, emit) {
      quizzManagement.reset();
    });
  }

}
