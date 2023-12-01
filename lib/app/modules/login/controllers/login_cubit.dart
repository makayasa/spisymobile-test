import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

import '../../../config/constant.dart';

class LoginCubit extends Cubit<Map> {
  LoginCubit()
      : super({
          'username': kDefaultPssword,
          'password': kDefaultPssword,
        });
  Map dataLogin = {
    'username': kDefaultPssword,
    'password': kDefaultPssword,
  };

  void onChangedUsername(String username) {
    final data = {};
    data.assignAll(state);
    data['username'] = username;
    emit(data);
  }

  void onChangePassword(String password) {
    final data = {};
    data.assignAll(state);
    data['password'] = password;
    emit(data);
  }
}
