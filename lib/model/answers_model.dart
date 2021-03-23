import 'dart:convert';

import 'package:admin/model/user_model.dart';

List<AnswersModel> answersModelFromMap(String str) => List<AnswersModel>.from(
    json.decode(str).map((x) => AnswersModel.fromMap(x)));

class AnswersModel {
  AnswersModel({
    this.id,
    this.answer,
    this.creatorDetails,
    this.isBlocked,
    this.timestamp,
    this.privateAnswer,
  });
  final String id;
  final String answer;
  final UserModel creatorDetails;
  final bool isBlocked;

  final int timestamp;
  final bool privateAnswer;

  AnswersModel copyWith({
    String id,
    String answer,
    UserModel creatorDetails,
    bool isBlocked,
    int timestamp,
    bool privateAnswer,
  }) {
    return AnswersModel(
      id: id ?? this.id,
      answer: answer ?? this.answer,
      creatorDetails: creatorDetails ?? this.creatorDetails,
      isBlocked: isBlocked ?? this.isBlocked,
      timestamp: timestamp ?? this.timestamp,
      privateAnswer: privateAnswer ?? this.privateAnswer,
    );
  }

  factory AnswersModel.fromMap(Map<String, dynamic> json) => AnswersModel(
        id: json["_id"],
        answer: json["answer"],
        creatorDetails: UserModel.fromMap(json["creatorId"]),
        timestamp: json["timestamp"],
        privateAnswer: json["privateAnswer"] ?? false,
        isBlocked: json.containsKey("isBlocked")
            ? (json["isBlocked"] ?? false)
            : false,
      );
}
