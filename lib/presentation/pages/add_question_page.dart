import 'package:flutter/material.dart';
import 'package:quizz_app_with_firebase_db/data/dataproviders/firebase_api.dart';
import 'package:quizz_app_with_firebase_db/data/models/themesEnum.dart';
import 'package:quizz_app_with_firebase_db/data/repositories/questions_repository.dart';
import 'package:quizz_app_with_firebase_db/presentation/pages/home_page.dart';
import 'package:quizz_app_with_firebase_db/presentation/widgets/button_widget.dart';
import 'package:quizz_app_with_firebase_db/presentation/widgets/dropDownWidget.dart';
import 'package:quizz_app_with_firebase_db/presentation/widgets/textFormFieldWidget.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({Key? key}) : super(key: key);

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  List<String> themes =
      QuestionsTheme.values.map((e) => e.toString().split(".").last).toList();
  List<String> answers = ["Vrai", "Faux"];
  final QuestionsRepository questionsRepository =
      QuestionsRepository(firebaseApi: FirebaseApi());
  final _formKey = GlobalKey<FormState>();

  final TextEditingController questionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  String answer = '';
  String theme = '';

  @override
  void initState() {
    super.initState();
    answer = answers[0];
    theme = themes[0];
  }

  @override
  void dispose() {
    questionController.dispose();
    imageController.dispose();
    super.dispose();
  }

  void addQuestion() {
    if (_formKey.currentState!.validate()) {
      try {
        questionsRepository.createQuestion(theme, questionController.text.trim(),
            getAnswer(answer), imageController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Question ajoutée avec succès"),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erreur lors de l'ajout de la question"),
          ),
        );
      }
    }
  }

  bool getAnswer(String answer) {
    if (answer == "Vrai") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ajouter question"),
        ),
        body: Row(
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 8,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text("Ajouter une question",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 50),
                      dropDownWidget(
                          hintText: "Veuillez choisir un thème",
                          items: themes,
                          selectedItem: themes[0],
                          onChanged: ((value) => {
                                setState(() {
                                  print("value: $value");
                                  theme = value.toString();
                                })
                              })),
                      const SizedBox(height: 20),
                      textFormFieldWidget(
                          hintText: "Saisir la question",
                          controller: questionController,
                          onTap: (() => {})),
                      const SizedBox(height: 20),
                      textFormFieldWidget(
                          hintText: "Saisir le lien d'image",
                          controller: imageController,
                          onTap: (() => {})),
                      const SizedBox(height: 20),
                      dropDownWidget(
                          hintText: "Veuillez choisir la réponse de question",
                          items: answers,
                          selectedItem: answers[0],
                          onChanged: ((value) => {
                                setState(() {
                                  answer = value ?? "";
                                })
                              })),
                      const SizedBox(height: 20),
                      buttonWidget(
                          text: "Soumettre",
                          textColor: Colors.white,
                          onPressed: (() => {
                                if (_formKey.currentState!.validate())
                                  {
                                    addQuestion(),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    )
                                  }
                              }))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ));
  }
}
