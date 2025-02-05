import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../controllers/result_controller.dart';

class TResultBody extends GetView<ResultController> {
  const TResultBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width - 16),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Lottie.asset(
                        TImages.cheers,
                        repeat: false,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Lottie.asset(
                        TImages.cheers,
                        repeat: false,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Lottie.asset(
                        TImages.cheers,
                        repeat: false,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Lottie.asset(
                        TImages.cheers,
                        repeat: false,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Lottie.asset(
                        TImages.cheers,
                        repeat: false,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Lottie.asset(
                        TImages.cheers,
                        repeat: false,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Lottie.asset(
                        TImages.cheers,
                        repeat: false,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Lottie.asset(
                        TImages.cheers,
                        repeat: false,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Lottie.asset(
                        TImages.cheers,
                        repeat: false,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width * 0.4,
                        lineWidth: 50.0,
                        percent: controller.resultPoint.value / controller.maxPoint.value,
                        center: Text(
                          "${((controller.resultPoint.value / controller.maxPoint.value) * 100).toStringAsFixed(2)}%\n${controller.resultPoint.value}/${controller.maxPoint.value}",
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.orange,
                        backgroundColor: Colors.blue,
                        animation: true,
                        animationDuration: 1500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
