import 'package:get/get.dart';
import 'package:todo/get/binding.dart';
import 'package:todo/get/screen.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: ScreenEmployees.pageId,
      page: () => ScreenEmployees(),
      binding: BindingEmployees(),
    ),
    GetPage(
      name: ScreenAddEmployees.pageId,
      page: () => ScreenAddEmployees(),
      binding: BindingEmployees(),
    ),
  ];
}
