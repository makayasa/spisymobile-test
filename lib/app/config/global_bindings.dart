import 'package:get/get.dart';
import 'package:spisymobile_test/app/controllers/database_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DatabaseController());
  }
}
