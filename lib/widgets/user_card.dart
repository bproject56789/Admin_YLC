import 'package:admin/Bloc/admin_bloc.dart';
import 'package:admin/email/send_email.dart';
import 'package:admin/model/user_model.dart';
import 'package:admin/pages/user_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserModel model;

  UserCard({
    Key key,
    this.model,
  }) : super(key: key);

  final AdminBloc bloc = AdminBloc();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UserDetails(model: model),
            ),
          );
        },
        child: Card(
          color: Colors.grey[50],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Image.network(
                      model.photo != null
                          ? model.photo
                          : model.isAdvocate
                              ? 'https://www.gujaratheadline.com/wp-content/uploads/2016/07/Advocate-1.jpeg'
                              : 'https://www.kindpng.com/picc/m/130-1300217_user-icon-member-icon-png-transparent-png.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      model.email,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      model.isAdvocate ? 'Advocate' : 'Member',
                      style: TextStyle(
                        color: model.isAdvocate ? Colors.blue : Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                model.isAdvocate
                    ? model.isVerified
                        ? Text(
                            '✔️\nVerified',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Container()
                    : Container(),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: !model.isSuspended
                          ? () {
                              bloc.suspendUser(model.id);
                              sendMail(model.email, model.name);
                            }
                          : () {
                              bloc.unsespendUser(model.id);
                            },
                      child: Text(
                        model.isSuspended ? 'Unsuspend' : 'Suspend',
                        style: TextStyle(
                          color: model.isSuspended ? Colors.green : Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: Text(
                    //     'Delete',
                    //     style: TextStyle(
                    //       color: Colors.red,
                    //       fontSize: 16,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
