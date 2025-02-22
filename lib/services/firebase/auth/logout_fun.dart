import 'package:get/get.dart';
import 'package:studify/core/services/services.dart';
import 'package:studify/view/modules/auth/screens/login.dart';

logOutFun() {
  final services = Get.put(Services());
  Get.offAll(const LoginPage());
  services.userInfo!.clear();
}
