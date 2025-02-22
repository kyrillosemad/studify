  import 'package:get/get_utils/src/get_utils/get_utils.dart';

  validator(value, max, min, type) {
    if (value.isEmpty) {
      return "Can't Be Empty";
    } else if (value.length > max) {
      return "Can't Be Greater Than $max";
    } else if (value.length < min) {
      return "Can't Be Less Than $min";
    } else if (type == "email") {
      if (!GetUtils.isEmail(value)) {
        return "Not Valid Email";
      }
    } else if (type == "phone") {
      if (!GetUtils.isPhoneNumber(value)) {
        return "Not Valid phone";
      }
    } else if (type == "username") {
      if (!GetUtils.isUsername(value)) {
        return "Not Valid username";
      }
    }

    return null;
  }
