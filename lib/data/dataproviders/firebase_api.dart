import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizz_app_with_firebase_db/data/models/question_model.dart';

class FirebaseApi {
  Future createQuestion(
      String theme, String questionText, bool answer, String image) async {
   
    QuestionModel question = QuestionModel(theme, questionText, answer, image);
    final docQuestion =
        FirebaseFirestore.instance.collection('questions').doc();
    await docQuestion.set(question.toJson());
  }

  Future fetchQuestions() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('questions').get();
    return querySnapshot.docs;
  }
}
