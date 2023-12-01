import 'package:bloc/bloc.dart';
import 'package:spisymobile_test/app/config/function_utils.dart';
import 'package:spisymobile_test/app/data_models/user_model.dart';

class DetailDataCubit extends Cubit<UserModel> {
  DetailDataCubit(this.asd)
      : super(
          UserModel(
            uuid: asd.uuid,
            name: asd.name,
            birthDate: asd.birthDate,
            gender: asd.gender,
            address: asd.address,
            age: asd.age
          ),
        );
  UserModel asd;

  void onChangedName(String name) {
    // state.name = name;
    final data = UserModel.fromJson(state.toJson());
    data.name = name;
    emit(data);
  }

  void onChangedAddres(String address) {
    // data.address = address;
    final data = UserModel.fromJson(state.toJson());
    data.name = address;
    emit(data);
  }

  void changeBirthDate(DateTime date) {
    final age = calcAge(date);
    state.birthDate = date;
    final data = UserModel.fromJson(state.toJson());
    data.birthDate = date;
    data.age = age;
    emit(data);
  }

  void changeGender(bool dataGender) {
    state.gender = dataGender;
    final data = UserModel.fromJson(state.toJson());
    data.gender = dataGender;
    emit(data);
  }

  @override
  void onChange(Change<UserModel> change) {
    // TODO: implement onChange
    logKey('onChange', change.currentState.toJson());
    super.onChange(change);
  }
}
