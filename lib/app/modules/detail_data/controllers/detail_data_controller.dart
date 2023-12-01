import 'package:get/get.dart';
import 'package:spisymobile_test/app/config/function_utils.dart';
import 'package:spisymobile_test/app/data_models/user_model.dart';

import '../../../controllers/database_controller.dart';
import 'detail_data_cubit.dart';

class DetailDataController extends GetxController {
  final dbController = Get.find<DatabaseController>();

  final name = ''.obs;
  final birthDate = DateTime.now().obs;
  final age = 0.obs;
  final gender = true.obs;
  final address = ''.obs;
  final arg = UserModel.init().obs;
  final isEdit = false.obs;

  @override
  void onInit() {
    super.onInit();
    logKey('arg di controller', Get.arguments);
    if (isNotEmpty(Get.arguments)) {
      arg.value = Get.arguments['data'];
      isEdit.value = Get.arguments['is_edit'];
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
