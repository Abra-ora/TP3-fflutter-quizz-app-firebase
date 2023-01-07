import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizz_app_with_firebase_db/data/dataproviders/firebase_api.dart';
import 'package:quizz_app_with_firebase_db/data/models/question_model.dart';

class QuestionsRepository {
  final FirebaseApi firebaseApi;

  QuestionsRepository({required this.firebaseApi});

     List<QuestionModel> quizzQuestions = [];

  Future<void> createQuestion(
      String theme, String questionText, bool answer, String image) async {
    try {
      return await firebaseApi.createQuestion(
          theme, questionText, answer, image);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<QuestionModel>> fetchQuestions() async {
    try {
      quizzQuestions.clear();
      await FirebaseFirestore.instance.collection('questions').get().then((value) => {
            for(var doc in value.docs){
              quizzQuestions.add(QuestionModel.fromJson(doc))
            }
      });
      return quizzQuestions;
    } catch (e) {
      throw Exception(e);
    }
  }
}
