import 'package:admin/Bloc/admin_bloc.dart';
import 'package:admin/widgets/full_screen.dart';
import 'package:flutter/material.dart';

import 'package:admin/model/user_model.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatelessWidget {
  final UserModel model;
  const UserDetails({
    Key key,
    this.model,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<AdminBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          model.isAdvocate ? 'Advocate Details' : 'Member Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Container(
                          height: 150,
                          width: 150,
                          child: Image.network(
                            model.photo != null
                                ? model.photo
                                : model.isAdvocate
                                    ? 'https://www.gujaratheadline.com/wp-content/uploads/2016/07/Advocate-1.jpeg'
                                    : 'https://www.kindpng.com/picc/m/130-1300217_user-icon-member-icon-png-transparent-png.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    model.isAdvocate
                        ? model.isVerified
                            ? Text(
                                'Verified ✔️',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                ),
                              )
                            : FlatButton(
                                color: Colors.white,
                                onPressed: () {
                                  bloc.verifiedUser(model.id);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Verify',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                        : Container(),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Name :  ${model.name}\n\nEmail :  ${model.email} ${model.phone != null ? '\n\nPhone no. :  ${model.phone}' : ''}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                model.isAdvocate
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Documents :',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '    Aadhar Card :',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 20),
                          getImage(
                            context,
                            model.documents['aadharCard'],
                          ),
                          SizedBox(height: 20),
                          Text(
                            '    Enrollment Number :',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 20),
                          getImage(
                            context,
                            model.documents['enrollmentNumber'],
                          ),
                          SizedBox(height: 20),
                        ],
                      )
                    : Container(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget getImage(BuildContext context, String image) {
  String placeholder =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfOAUEVOmpaRxO3ZO2_QRWc1kea1L9CF9dVg&usqp=CAU';
  return GestureDetector(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullScreen(
          image: image ?? placeholder,
        ),
      ),
    ),
    child: Container(
      height: 246,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Image.network(
          image ?? placeholder,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
