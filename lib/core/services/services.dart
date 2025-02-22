import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services extends GetxService {
  SharedPreferences? userInfo;

  Future<Services> init() async {
    userInfo = await SharedPreferences.getInstance();
    return this;
  }
}
