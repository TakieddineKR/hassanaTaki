import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../constant/colors/app_color.dart';

class LoadingService {
  showLoading() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColor.kBackGroundColor
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..indicatorColor = AppColor.kPrimaryColor
      ..textColor = AppColor.kPrimaryColor
      ..userInteractions = false
      ..progressColor = AppColor.kPrimaryColor;

    EasyLoading.show(status: 'loading'.tr, dismissOnTap: false);
  }

  showSuccess(String status) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColor.kBackGroundColor
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..indicatorColor = AppColor.kPrimaryColor
      ..textColor = AppColor.kPrimaryColor;

    EasyLoading.showSuccess(status,
        duration: const Duration(milliseconds: 500));
  }

  showError(String status) {
    EasyLoading.showError(status);
  }

  dismissLoading() {
    EasyLoading.dismiss();
  }
}
