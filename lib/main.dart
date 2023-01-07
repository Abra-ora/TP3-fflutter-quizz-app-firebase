import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app_with_firebase_db/buisness_logic/bloc/get_quiz_questions_bloc/quizz_questions_bloc.dart';
import 'package:quizz_app_with_firebase_db/buisness_logic/cubit/dark_mode_cubit.dart';
import 'package:quizz_app_with_firebase_db/data/models/question_model.dart';
import 'package:quizz_app_with_firebase_db/data/repositories/questions_repository.dart';
import 'package:quizz_app_with_firebase_db/presentation/pages/add_question_page.dart';
import 'package:quizz_app_with_firebase_db/presentation/pages/home_page.dart';
import 'package:quizz_app_with_firebase_db/presentation/pages/quizz_page.dart';
import 'package:quizz_app_with_firebase_db/presentation/pages/result.dart';
import 'data/dataproviders/firebase_api.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(BlocProvider(
    create: (context) => DarkModeCubit(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<QuestionModel> questions = [];
    // final quizzQuestionsBloc = QuizzQuestionsBloc(
    //     questionsRepository: QuestionsRepository(firebaseApi: FirebaseApi()), nextQuestionBloc: NextQuestionBloc());
     
    // quizzQuestionsBloc.add(getQuizzQuestionsEvent());
    // if (quizzQuestionsBloc.state is QuestionLoaded) {
    //   questions = (quizzQuestionsBloc.state as QuestionLoaded).questions;
    // }
     
    return BlocBuilder<DarkModeCubit, DarkModeState>(
      builder: (context, state) {
        final quizzQuestionsBloc = QuizzQuestionsBloc(questionsRepository: QuestionsRepository(firebaseApi: FirebaseApi()));
        // quizzQuestionsBloc.add(getQuizzQuestionsEvent());
        return MaterialApp(title: 'Flutter Demo', theme: state.theme, 
        routes: {
          '/': (context) => HomePage(),
          '/addQuestion': (context) => const AddQuestionPage(),
          '/quizz': (context) => BlocProvider.value(
            value: quizzQuestionsBloc,
            child: const QuizzPage(),
          ),
          '/result':(context) => BlocProvider.value(
            value: quizzQuestionsBloc, 
            child: QuizzResult()
            ),
        });
      },
    );
  }
}
