import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/test_controller.dart';
import 'widgets/bottom_buttons.dart';
import 'widgets/scroll_numbers.dart';
import 'widgets/test_body.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TestController());
    return WillPopScope(
      onWillPop: () async {
        return await controller.showEndDialog();
      },
      // Optional additional parameters if your AdaptiveWillPopScope supports them:
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Тест'),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: controller.showEndDialog,
              child: Text(
                "Тестті аяқтау",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            SizedBox(width: 10.h),
          ],
        ),
        body: Column(
          children: [
            const ScrollNumbers(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Obx(() {
                  if (controller.loading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const SafeArea(
                      top: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TestBody(),
                          BottomButtons(),
                        ],
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
