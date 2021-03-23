import 'dart:async';

import 'package:admin/api/questions_api.dart';
import 'package:admin/model/questions_model.dart';
import 'package:rxdart/subjects.dart';

class QuestionsBloc {
  final _questions = BehaviorSubject<List<QuestionsModel>>();
  Timer _timer;

  Stream<List<QuestionsModel>> get questions => _questions.stream;

  void init({String userId}) {
    QuestionsApi.fetchQuestions().then((event) {
      if (event != null) {
        if (!_questions.isClosed) _questions.add(event);
      }
    });
  }

  void dispose() {
    _timer?.cancel();
    _questions.close();
  }
}
