import 'dart:async';

import 'package:admin/Bloc/admin_bloc.dart';
import 'package:admin/api/questions_api.dart';
import 'package:admin/model/answers_model.dart';
import 'package:admin/model/questions_model.dart';
import 'package:admin/pages/questions_module/bloc/answers_bloc.dart';
import 'package:admin/widgets/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnswersPage extends StatefulWidget {
  final QuestionsModel questionsModel;

  const AnswersPage({Key key, this.questionsModel}) : super(key: key);

  @override
  _AnswersPageState createState() => _AnswersPageState();
}

class _AnswersPageState extends State<AnswersPage> {
  QuestionsModel questionsModel;
  AnswersBloc bloc;
  Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      QuestionsApi.fetchQuestionById(widget.questionsModel.id).then((value) {
        if (value != null) {
          questionsModel = value;
          setState(() {});
        }
      });
    });

    questionsModel = widget.questionsModel;
    bloc = AnswersBloc(questionsModel.id);
    bloc.init();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Answers",
        ),
        actions: [
          FlatButton(
            child: questionsModel.isBlocked
                ? Text('UNBLOCK QUESTION')
                : Text('BLOCK QUESTION'),
            onPressed: () async {
              bool isBlocked = questionsModel.isBlocked;
              if (isBlocked) {
                if (await CustomDialogs.generalConfirmationDialogWithMessage(
                    context,
                    'Are you sure you want to unblock this question')) {
                  QuestionsApi.blockUnblockQuestion(
                    questionsModel.id,
                    false,
                  );
                }
              } else {
                var result = await CustomDialogs.showBlockDialog(
                    context, 'Are you sure you want to block this question?');
                if (result != null &&
                    result.subject != null &&
                    result.body != null) {
                  var user =
                      Provider.of<AdminBloc>(context, listen: false).getUser(
                    questionsModel.creatorId,
                  );
                  QuestionsApi.blockUnblockQuestion(
                    questionsModel.id,
                    true,
                    model: result,
                    email: user?.email,
                    name: user?.name,
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 8,
                    ),
                    child: Text(questionsModel.question),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 12),
              StreamBuilder<List<AnswersModel>>(
                stream: bloc.answers,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data.isEmpty) {
                    return Align(
                      alignment: Alignment.center,
                      child: Text("No answers"),
                    );
                  }

                  return ListBody(
                    children: snapshot.data
                        .map(
                          (a) => Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 20,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      child: Image.network(
                                        a.creatorDetails.photo ??
                                            'https://www.kindpng.com/picc/m/130-1300217_user-icon-member-icon-png-transparent-png.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(a.answer),
                                      SizedBox(height: 8),
                                      Text(
                                        '- ' + a.creatorDetails.name,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.block,
                                      color: a.isBlocked
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                    onPressed: () async {
                                      bool isBlocked = a.isBlocked;
                                      if (isBlocked) {
                                        if (await CustomDialogs
                                            .generalConfirmationDialogWithMessage(
                                                context,
                                                'Are you sure you want to unblock this answer')) {
                                          QuestionsApi.blockUnblockAnswer(
                                            a.id,
                                            false,
                                          );
                                        }
                                      } else {
                                        var result =
                                            await CustomDialogs.showBlockDialog(
                                                context,
                                                'Are you sure you want to block this answer?');
                                        if (result != null &&
                                            result.subject != null &&
                                            result.body != null) {
                                          var user = Provider.of<AdminBloc>(
                                                  context,
                                                  listen: false)
                                              .getUser(
                                            a.creatorDetails.id,
                                          );
                                          QuestionsApi.blockUnblockAnswer(
                                            a.id,
                                            true,
                                            model: result,
                                            email: user?.email,
                                            name: user?.name,
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
