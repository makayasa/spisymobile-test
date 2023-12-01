import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:spisymobile_test/app/bloc/list_users_cubit.dart';
import 'package:spisymobile_test/app/controllers/database_controller.dart';

import '../../../config/function_utils.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final dbController = Get.find<DatabaseController>();

  void initState() async {
    final res = await dbController.getAllUsers();
    logKey('res', res);
    if (isEmpty(res)) {
      return;
    }
    final listUserCubit = Get.context!.read<ListUsersCubit>();
    listUserCubit.udpateUsers(res);
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    initState();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
