import 'package:get/get.dart';
import 'package:todo/get/controller.dart';

class BindingAddEmployee extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerAddEmployee>(() => ControllerAddEmployee());
  }
}
