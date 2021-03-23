import 'dart:async';

import 'package:admin/api/users_api.dart';
import 'package:admin/model/user_model.dart';
import 'package:rxdart/subjects.dart';

class AdminBloc {
  final _model = BehaviorSubject<List<UserModel>>();
  Stream<List<UserModel>> get listOfUserModel => _model.stream;
  Timer _timer;

  void init() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      UserApi.getAllUsers().then((value) {
        if (value != null) {
          _model.add(value);
        }
      });
    });
  }

  UserModel getUser(String userId) {
    return _model.value.firstWhere(
      (element) => element.id == userId,
      orElse: () => null,
    );
  }

  void suspendUser(String userId) {
    UserApi.updateUser(userId, {'isSuspended': true});
  }

  void unsespendUser(String userId) {
    UserApi.updateUser(userId, {'isSuspended': false});
  }

  void verifiedUser(String userId) {
    UserApi.updateUser(userId, {'isVerified': true});
  }

  void unverifiedUser(String userId) {
    UserApi.updateUser(userId, {'isVerified': false});
  }

  void dispose() {
    _timer?.cancel();
  }
}
