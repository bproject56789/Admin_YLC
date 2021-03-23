import 'dart:async';
import 'dart:convert';

import 'package:admin/model/user_model.dart';
import 'package:http/http.dart' as http;

// const String BaseUrl = 'https://pure-plateau-44642.herokuapp.com/';
const String BaseUrl = 'http://192.168.43.206:3000/';

class UserApi {
  static const _endPoint = BaseUrl + "users/";

  static Future<List<UserModel>> getAllUsers() async {
    var result = await http.get(_endPoint);
    if (result.statusCode == 200) {
      List<dynamic> data = json.decode(result.body);
      List<UserModel> advocates = [];
      data.forEach((element) {
        advocates.add(UserModel.fromMap(element));
      });
      return advocates;
    } else {
      return null;
    }
  }

  static Future<bool> updateUser(
      String userId, Map<String, dynamic> map) async {
    try {
      var result = await http.patch(
        _endPoint + userId,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(map),
      );
      print(result.body);
      if (result.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
