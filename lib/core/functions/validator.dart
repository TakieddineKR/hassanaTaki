import 'package:get/get.dart';

validator(String value, int min, int max, String type) {
  // chekc if entred value is a username
  if (type == 'username') {
    if (!GetUtils.isUsername(value)) {
      return "User Name too long";
    }
  }

  // chekc if entred value is a phone number
  if (type == 'phone') {
    if (!GetUtils.isPhoneNumber(value)) {
      return "invalid phone number";
    }
  }
  // check if entred value is empty
  if (value.isEmpty) {
    return 'cant be empty';
  }
  // check if entred value is less than min
  if (value.length < min) {
    return '${'cant be less than'} $min';
  }
  // check if entred value is less than max
  if (value.length > max) {
    return '${'cant be more than'.tr} $max';
  }
}
