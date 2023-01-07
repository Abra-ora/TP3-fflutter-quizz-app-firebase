import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String _theme;
  String _question;
  bool _answer;
  String _image;

  get theme => _theme;
  get question => _question;
  get answer => _answer;
  get image => _image;

  QuestionModel(this._theme, this._question, this._answer, this._image);

  toJson() {
    return {
      "theme": _theme,
      "question": _question,
      "answer": _answer,
      "image": _image,
    };
  }

  static QuestionModel fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return QuestionModel(doc.data()['theme'], doc.data()['question'],
        doc.data()['answer'], doc.data()['image']);
  }
}
