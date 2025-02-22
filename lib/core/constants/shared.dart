import 'package:get/get.dart';
import 'package:studify/core/services/services.dart';

class Shared {
  final Services services = Get.put(Services());

  late String? id;
  late String? userName;
  late String? type;

  Shared() {
    id = services.userInfo!.getString("id");
    userName = services.userInfo!.getString("username");
    type = services.userInfo!.getString("type");
  }
}
