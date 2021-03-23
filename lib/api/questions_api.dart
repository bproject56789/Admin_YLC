import 'dart:async';
import 'dart:convert';

import 'package:admin/api/users_api.dart';
import 'package:admin/email/send_email.dart';
import 'package:admin/model/answers_model.dart';
import 'package:admin/model/questions_model.dart';
import 'package:admin/widgets/custom_dialogs.dart';
import 'package:http/http.dart' as http;

class QuestionsApi {
  static const _questionsEndPoint = BaseUrl + "questions/";
  static const _answersEndPoint = BaseUrl + "answers/";

  static Future<List<QuestionsModel>> fetchQuestions() async {
    var result = await http.get(
      _questionsEndPoint,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json"
      },
    );

    if (result.statusCode == 200) {
      return questionsModelFromMap(result.body);
    } else {
      print(result.body);
      throw 'Something went wrong';
    }
  }

  static Future<QuestionsModel> fetchQuestionById(String questionId) async {
    var result = await http.get(
      _questionsEndPoint + questionId,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json"
      },
    );

    if (result.statusCode == 200) {
      return QuestionsModel.fromMap(json.decode(result.body));
    } else {
      print(result.body);
      throw 'Something went wrong';
    }
  }

  static Future<List<AnswersModel>> fetchAnswers(String questionId) async {
    try {
      var result = await http.get(_answersEndPoint + questionId);
      if (result.statusCode == 200) {
        return answersModelFromMap(result.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> blockUnblockAnswer(
    String answerId,
    bool block, {
    ReplyEmailModel model,
    String email,
    String name,
    String message,
  }) async {
    var result = await http.patch(
      _answersEndPoint + answerId,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json"
      },
      body: json.encode(
        {
          "isBlocked": block,
        },
      ),
    );
    if (model != null) {
      await sendMailWithBody(
        email,
        name,
        model.subject,
        model.body,
      );
    }
  }

  static Future<void> blockUnblockQuestion(
    String questionId,
    bool block, {
    ReplyEmailModel model,
    String email,
    String name,
    String message,
  }) async {
    var result = await http.patch(
      _questionsEndPoint + questionId,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json"
      },
      body: json.encode(
        {
          "isBlocked": block,
        },
      ),
    );
    if (model != null) {
      await sendMailWithBody(
        email,
        name,
        model.subject,
        model.body,
      );
    }
  }
}
