import 'package:admin/Bloc/admin_bloc.dart';
import 'package:admin/model/user_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class UserData {
//   final int number;
//   final Color color;
//   UserData({
//     this.number,
//     this.color,
//   });
// }

class LabelCount {
  final String userType;
  final int userCount;

  LabelCount(this.userType, this.userCount);
}

class Statistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<AdminBloc>(context);
    return Scaffold(
      // backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: bloc.listOfUserModel,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Loading...",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          }
          List<UserModel> models = snapshot.data;
          int advocateCount = 0;
          int suspendedUsers = 0;
          models.forEach((element) {
            if (element.isSuspended) {
              suspendedUsers += 1;
            }
            if (element.isAdvocate) {
              advocateCount += 1;
            }
          });
          List<LabelCount> data = [
            LabelCount("User", models.length - advocateCount),
            LabelCount("Advocates", advocateCount),
          ];

          List<charts.Series<LabelCount, String>> series = [
            charts.Series(
              seriesColor: charts.Color.white,
              displayName: "User Count",
              id: "User Count",
              data: data,
              labelAccessorFn: (LabelCount row, _) =>
                  '${row.userType}: ${row.userCount}',
              domainFn: (LabelCount grades, _) => grades.userType,
              measureFn: (LabelCount grades, _) => grades.userCount,
            )
          ];

          return models.isEmpty
              ? Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(
                  height: 246,
                  child: charts.PieChart(
                    series,
                    animate: true,
                    defaultRenderer: new charts.ArcRendererConfig(
                      arcWidth: 60,
                      arcRendererDecorators: [
                        charts.ArcLabelDecorator(),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
