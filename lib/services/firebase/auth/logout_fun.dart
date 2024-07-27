import 'package:get/get.dart';
import 'package:studify/main.dart';
import 'package:studify/view/view%20modules/auth/screens/login.dart';

logOutFun() {
  Get.offAll(const Login());
  userInfo!.clear();
}
