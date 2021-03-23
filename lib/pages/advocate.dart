import 'dart:ui';
import 'package:admin/Bloc/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:admin/model/user_model.dart';
import 'package:admin/widgets/user_card.dart';
import 'package:provider/provider.dart';

class Advocate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<AdminBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: StreamBuilder(
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
            List<UserModel> model = [];
            snapshot.data.forEach((data) {
              if (data.isAdvocate) {
                model.add(data);
              }
            });

            return model.isEmpty
                ? Center(
                    child: Text(
                      'No User',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: model.length,
                    itemBuilder: (context, index) {
                      return UserCard(
                        model: model[index],
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
