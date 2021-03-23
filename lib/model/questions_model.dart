import 'dart:convert';

List<QuestionsModel> questionsModelFromMap(String str) =>
    List<QuestionsModel>.from(
        json.decode(str).map((x) => QuestionsModel.fromMap(x)));

class QuestionsModel {
  QuestionsModel({
    this.id,
    this.question,
    this.creatorId,
    this.totalAnswers,
    this.timestamp,
    this.isBlocked,
  });
  String id;
  final String question;
  final String creatorId;
  final int totalAnswers;
  final int timestamp;
  final bool isBlocked;

  factory QuestionsModel.fromMap(Map<String, dynamic> json) => QuestionsModel(
        id: json["_id"],
        question: json["question"],
        creatorId: json["creatorId"],
        totalAnswers: json["totalAnswers"],
        timestamp: json["timestamp"],
        isBlocked: json.containsKey("isBlocked")
            ? (json["isBlocked"] ?? false)
            : false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "question": question,
        "creatorId": creatorId,
        "totalAnswers": totalAnswers,
        "isBlocked": isBlocked ?? false,
        "timestamp": timestamp,
      };
}
