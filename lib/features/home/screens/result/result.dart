import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/result_controller.dart';
import '../home/home.dart';
import 'widgets/result_body.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResultController());
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Нәтиже'),
          automaticallyImplyLeading: false,
          centerTitle: false,
          actions: [
            InkWell(
              onTap: () {
                Get.offAll(() => const HomeScreen());
              },
              child: Text(
                "Басты бет",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            SizedBox(width: 20.h),
          ],
        ),
        body: TResultBody(),
      ),
    );
  }
}
