import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/test_controller.dart';

class ScrollNumbers extends GetView<TestController> {
  const ScrollNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: ListView.separated(
        controller: controller.scrollController,
        // Add the scroll controller here
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 24.h,
        ),
        itemBuilder: (context, index) => Obx(() => InkWell(
              onTap: () {
                controller.changeQuestion(index);
              },
              child: Container(
                height: 35.h,
                width: 35.h,
                padding: const EdgeInsets.all(5),
                decoration: controller.buildDecoration(context, index),
                child: controller.buildNumberText(context, index),
              ),
            )),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: controller.showQuestions.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
