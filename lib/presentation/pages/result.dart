import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app_with_firebase_db/buisness_logic/bloc/get_quiz_questions_bloc/quizz_questions_bloc.dart';
import 'package:quizz_app_with_firebase_db/presentation/widgets/button_widget.dart';

class QuizzResult extends StatefulWidget {
  int score = 0;
  int total = 100;
  // final Function reset;

  QuizzResult({super.key});

  @override
  _QuizzResultState createState() => _QuizzResultState();
}

class _QuizzResultState extends State<QuizzResult> {
  String mention = "";
  @override
  void initState() {
    super.initState();
  }

  getMention(int score) {
    var percentage = score / widget.total * 100;
    if (percentage >= 90) {
      mention = "Excellent";
    } else if (percentage >= 80 && percentage < 90) {
      mention = "Très bien";
    } else if (percentage >= 60 && percentage < 80) {
      mention = "Bien";
    } else if (percentage < 60) {
      mention = "Perseverer!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizzQuestionsBloc = BlocProvider.of<QuizzQuestionsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Résultat"),
        backgroundColor: Colors.grey[850],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Votre score est : ${70}/${widget.total}",
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            buttonWidget(
                text: "Recommencer le quiz",
                textColor: Colors.white,
                onPressed: (() => {
                      quizzQuestionsBloc.add(ResetQuizzEvent()),
                      Navigator.pushNamed(context, '/')
                    }))
          ],
        ),
      ),
    );
    // );
  }
}
