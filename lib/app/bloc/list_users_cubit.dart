import 'package:bloc/bloc.dart';
import 'package:spisymobile_test/app/data_models/user_model.dart';

class ListUsersCubit extends Cubit<List<UserModel>> {
  ListUsersCubit() : super([]);
  List<UserModel> users = <UserModel>[];

  void udpateUsers(List<UserModel> data) {
    emit([...data]);
  }

  void getUsers(args) {}

  @override
  void onChange(Change<List<UserModel>> change) {
    // TODO: implement onChange
    super.onChange(change);
  }
}
