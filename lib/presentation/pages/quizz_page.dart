import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app_with_firebase_db/buisness_logic/bloc/get_quiz_questions_bloc/quizz_questions_bloc.dart';
import 'package:quizz_app_with_firebase_db/data/models/question_model.dart';
import 'package:quizz_app_with_firebase_db/presentation/pages/result.dart';
import 'package:quizz_app_with_firebase_db/presentation/widgets/responseButtonWidget.dart';

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
    final quizzQuestionsBloc = BlocProvider.of<QuizzQuestionsBloc>(context);

    quizzQuestionsBloc.add(getQuizzQuestionsEvent());

    return Scaffold(
        appBar: AppBar(
          title: const Text("Quizz : questions et réponses"),
          backgroundColor: Colors.grey[850],
        ),
        body: BlocConsumer<QuizzQuestionsBloc, QuizzQuestionsState>(
            listener: (context, state) {
          if (state is QuestionLoaded) {
            questions = state.questions;
            questions.shuffle();
          } else if (state is ToNextQuestion) {
            currentQuestionIndex = state.questionIndex;
            scoreKeeper = state.scoreKeeper;
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

                            // width: MediaQuery.of(context).size.width - 12,
                            // height: MediaQuery.of(context).size.height / 2.2,
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
                                    .add(ToNextQuestionEvent(questions, false))
                              }))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: scoreKeeper,
                ),
              ],
            );
          } else if (state is QuestionLoading) {
            print("In loading state");
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizzFinished) {
            print("In finished state");
            Navigator.pushNamed(context, '/result');
            return const SnackBar(content: Text("Quizz terminé"));
          } else if (state is QuestionLoadingError) {
            print("In error state");
            Navigator.pushNamed(context, "/");
            return SnackBar(content: Text(state.error));
          } else {
            print("In default state $state");
            return const Center(child: Text("Error"));
          }
        }));
  }
}
