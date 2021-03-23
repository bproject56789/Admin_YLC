import 'package:flutter/material.dart';

class CustomDialogs {
  static Future<ReplyEmailModel> showBlockDialog(
    BuildContext context,
    String title,
  ) async {
    TextEditingController subject = TextEditingController();
    TextEditingController body = TextEditingController();
    final key = GlobalKey<FormState>();
    return showDialog(
          context: context,
          builder: (_context) => AlertDialog(
            title: Text(title),
            content: Form(
              key: key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: subject,
                    decoration: InputDecoration(
                      hintText: "Please specify a subject",
                    ),
                    validator: (v) => v == null || v.isEmpty
                        ? 'Field can\'t be left blank'
                        : null,
                  ),
                  TextFormField(
                    controller: body,
                    decoration: InputDecoration(
                      hintText: "Please specify a reason",
                    ),
                    validator: (v) => v == null || v.isEmpty
                        ? 'Field can\'t be left blank'
                        : null,
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(_context).pop(null);
                },
                child: Text("No"),
              ),
              FlatButton(
                onPressed: () {
                  if (key.currentState.validate()) {
                    Navigator.of(_context).pop(ReplyEmailModel(
                      subject.text,
                      body.text,
                    ));
                  }
                },
                child: Text("Yes"),
              ),
            ],
          ),
        ) ??
        false;
  }

  static Future<bool> generalConfirmationDialogWithMessage(
    BuildContext context,
    String title,
  ) async {
    return showDialog(
          context: context,
          builder: (_context) => AlertDialog(
            title: Text(title),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(_context).pop(false);
                },
                child: Text("No"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(_context).pop(true);
                },
                child: Text("Yes"),
              ),
            ],
          ),
        ) ??
        false;
  }

  /// return true when close button is pressed
  static Future<bool> generalDialogWithCloseButton(
    BuildContext context,
    String title,
  ) async {
    return showDialog(
          context: context,
          builder: (_context) => AlertDialog(
            title: Text(title),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(_context).pop(true);
                },
                child: Text("Close"),
              ),
            ],
          ),
        ) ??
        false;
  }
}

class ReplyEmailModel {
  final String subject;
  final String body;

  ReplyEmailModel(this.subject, this.body);
}
