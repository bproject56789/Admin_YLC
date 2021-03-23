import 'package:admin/model/questions_model.dart';
import 'package:admin/pages/questions_module/bloc/question_bloc.dart';
import 'package:admin/pages/questions_module/screens/answers_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// If [userId] is [null] then it displays all questions otherwise questions asked by that user only
class QuestionsPage extends StatefulWidget {
  final String userId;

  const QuestionsPage({Key key, this.userId}) : super(key: key);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final QuestionsBloc bloc = QuestionsBloc();

  @override
  void initState() {
    print(widget.userId);
    bloc.init(userId: widget.userId);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<QuestionsModel>>(
        stream: bloc.questions,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data.isEmpty) {
            return Center(
              child: Text("No Questions"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data[index].question),
                    subtitle: Text(
                      "${snapshot.data[index].totalAnswers} answers",
                    ),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Provider.value(
                            value: snapshot.data[index],
                            updateShouldNotify: (_, __) => true,
                            child: AnswersPage(
                              questionsModel: snapshot.data[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
