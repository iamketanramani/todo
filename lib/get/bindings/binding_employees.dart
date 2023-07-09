import 'package:get/get.dart';
import 'package:todo/get/controller.dart';

class BindingEmployees extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerEmployees>(() => ControllerEmployees());
  }
}
