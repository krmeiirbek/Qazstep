import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShowDialogs {
  static deleteShowDialog({required title, required onPressed, middleText = '', duration = 1}) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(16.h),
      title: title,
      titleStyle: Theme.of(Get.context!).textTheme.bodyLarge!.apply(fontStyle: FontStyle.normal, fontSizeDelta: 5),
      middleText: middleText,
      middleTextStyle: Theme.of(Get.context!).textTheme.bodyMedium!.apply(fontSizeDelta: 2),
      confirm: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 24.h), child: const Text('Жою')),
      ),
      cancel: OutlinedButton(onPressed: () => Navigator.of(Get.overlayContext!).pop(), child: const Text('Болдырмау')),
    );
  }

  static logoutShowDialog({required title, required onPressed, middleText = '', duration = 1}) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(16.h),
      title: title,
      titleStyle: Theme.of(Get.context!).textTheme.bodyLarge!.apply(fontStyle: FontStyle.normal, fontSizeDelta: 5),
      middleText: middleText,
      middleTextStyle: Theme.of(Get.context!).textTheme.bodyMedium!.apply(fontSizeDelta: 2),
      confirm: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.h),
          child: const Text(
            'Шығу',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text(
          'Болдырмау',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  static classicShowDialog({required title, required onPressed, middleText = '', duration = 1}) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(16.h),
      title: title,
      titleStyle: Theme.of(Get.context!).textTheme.bodyLarge!.apply(fontStyle: FontStyle.normal, fontSizeDelta: 5),
      middleText: middleText,
      middleTextStyle: Theme.of(Get.context!).textTheme.bodyMedium!.apply(fontSizeDelta: 2),
      confirm: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white, side: const BorderSide(color: Colors.white)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.h),
          child: const Text('Ия', style: TextStyle(color: Colors.black)),
        ),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white, side: const BorderSide(color: Colors.white)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.h),
          child: const Text('Жоқ', style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
