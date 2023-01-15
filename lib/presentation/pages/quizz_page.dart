import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app_with_firebase_db/buisness_logic/bloc/get_quiz_questions_bloc/quizz_questions_bloc.dart';
import 'package:quizz_app_with_firebase_db/data/models/question_model.dart';
import 'package:quizz_app_with_firebase_db/presentation/widgets/responseButtonWidget.dart';

import '../widgets/button_widget.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({super.key});

  @override
  _QuizzPageState createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage>
    with SingleTickerProviderStateMixin {
  List<QuestionModel> questions = [];
  List<Icon> scoreKeeper = [];
  int currentQuestionIndex = 0;


  @override
  Widget build(BuildContext context) {
    int totalQuestions = 100;
    int score = 0;
    String mention = "";

    getMention(int score) {
      var percentage = score / totalQuestions * 100;
      String mention = "";
      if (percentage >= 90) {
        mention = "Excellent";
      } else if (percentage >= 80 && percentage < 90) {
        mention = "Très bien";
      } else if (percentage >= 60 && percentage < 80) {
        mention = "Bien";
      } else if (percentage < 60) {
        mention = "Perseverer!";
      }
      return mention;
    }

    final quizzQuestionsBloc = BlocProvider.of<QuizzQuestionsBloc>(context);
    quizzQuestionsBloc.add(getQuizzQuestionsEvent());

    return Scaffold(
        appBar: AppBar(
          title: const Text("Quizz : questions et réponses"),
          backgroundColor: Colors.grey[850],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              quizzQuestionsBloc.add(ResetQuizzEvent());
              Navigator.pushNamed(context, '/');
            },
          ),
        ),
        body: BlocConsumer<QuizzQuestionsBloc, QuizzQuestionsState>(
            listener: (context, state) {
          if (state is QuestionLoaded) {
            questions = state.questions;
            questions.shuffle();
          } else if (state is ToNextQuestion) {
            currentQuestionIndex = state.questionIndex;
            scoreKeeper = state.scoreKeeper;
          } else if (state is QuizzFinished) {
            score = state.score;
            mention = getMention(score);
          }
        }, builder: (context, state) {
          if (state is QuestionLoaded || state is ToNextQuestion) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // child: Row(
                        children: [
                          Text(
                            "Theme : ${questions[currentQuestionIndex].theme}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${questions[currentQuestionIndex].question}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CachedNetworkImage(
                            height: max(250, 200),
                            imageUrl: questions[currentQuestionIndex].image,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                        //  )
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: responseButtonWidget(
                          text: "Vrai",
                          backgroundColor: Colors.green,
                          onPressed: () {
                            print(
                                "length : ${questions.length}:  index : $currentQuestionIndex");
                            quizzQuestionsBloc
                                .add(ToNextQuestionEvent(questions, true));
                          })),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: responseButtonWidget(
                          text: "Faux",
                          backgroundColor: Colors.red,
                          onPressed: (() => {
                                quizzQuestionsBloc
                                    .add(ToNextQuestionEvent(questions, false)),
                              }))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: scoreKeeper,
                ),
              ],
            );
          } else if (state is QuizzFinished) {
            print("Quizzppage : In quizz finished state");
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Votre score est : $score/$totalQuestions",
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    mention,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buttonWidget(
                      text: "Recommencer le quiz",
                      textColor: Colors.white,
                      onPressed: (() => {
                            quizzQuestionsBloc.add(ResetQuizzEvent()),
                            Navigator.pushNamed(context, '/'),
                          }))
                ],
              ),
            );
          } else if (state is QuestionLoading || questions.isEmpty) {
            print("In loading state");
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuestionLoadingError) {
            print("In error state");
            Navigator.pushNamed(context, "/");
            return SnackBar(content: Text(state.error));
          } else {
            print("quizz_question_widget: In default state $state");
            return const Center(child: Text("Error"));
          }
        }));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
