import 'dart:convert';

import 'package:http/http.dart' as http;

const Map<String, dynamic> verifiedSenderDetails = {
  "email": "user15ec27@gmail.com",
  "name": "YLC Admin"
};

const String apiKey =
    "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";

const mailUrl = "https://api.sendgrid.com/v3/mail/send";

Future<bool> sendMail(String email, String name) async {
  Map<String, dynamic> body = {
    "personalizations": [
      {
        "to": [
          {
            "email": email,
            "name": name,
          }
        ],
        "dynamic_template_data": {"email": email}
      }
    ],
    "from": verifiedSenderDetails,
    "reply_to": verifiedSenderDetails,
    "template_id": "d-1614b3a400ca48d9bd2d56b20c744e78"
  };

  try {
    var result = await http.post(
      mailUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode(body),
    );

    if (result.statusCode > 200 && result.statusCode < 300) {
      return true;
    }
  } on Exception catch (e) {
    print(e);
  }
  return false;
}

Future<bool> sendMailWithBody(
  String email,
  String name,
  String subject,
  String content,
) async {
  Map<String, dynamic> body = {
    "personalizations": [
      {
        "to": [
          {
            "email": email,
            "name": name,
          }
        ],
      }
    ],
    "from": verifiedSenderDetails,
    "reply_to": verifiedSenderDetails,
    "subject": subject,
    "content": [
      {
        "type": "text/plain",
        "value": content,
      }
    ]
  };

  try {
    var result = await http.post(
      mailUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode(body),
    );
    print(result.statusCode);
    if (result.statusCode > 200 && result.statusCode < 300) {
      return true;
    }
  } on Exception catch (e) {
    print(e);
  }
  return false;
}
