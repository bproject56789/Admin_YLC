import 'dart:async';

import 'package:admin/api/questions_api.dart';
import 'package:admin/model/answers_model.dart';
import 'package:rxdart/subjects.dart';

class AnswersBloc {
  final String questionId;
  Timer _timer;
  AnswersBloc(this.questionId);

  final _answers = BehaviorSubject<List<AnswersModel>>();

  Stream<List<AnswersModel>> get answers => _answers.stream;

  void init() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      QuestionsApi.fetchAnswers(questionId).then((event) {
        if (event != null) {
          if (!_answers.isClosed) _answers.add(event);
        }
      });
    });
  }

  void dispose() {
    _answers.close();
    _timer?.cancel();
  }
}
