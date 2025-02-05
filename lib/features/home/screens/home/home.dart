import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/qbutton.dart';
import '../../controllers/home_controller.dart';
import '../pbb/pbb_screen.dart';
import '../ubt/ubt_screen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: const Text("QAZSTEP Тест қолданбасы")),
      body: SafeArea(
        child: Obx(() {
          if (HomeController.instance.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  QButton(
                    onTap: () => Get.to(() => const UBTScreen(), arguments: 'ҰБТ'),
                    btnText: 'Оқушыларға(ҰБТ, ЕНТ)',
                  ),
                  QButton(
                    onTap: () => Get.to(() => const PBBScreen(), arguments: 'ПББ'),
                    btnText: 'Мұғалімдерге(ПББ, ОЗП)',
                  ),
                ],
              ),
              Column(
                children: [
                  Text('Тест тапсыру мүмкіндіктер саны: ${controller.user.value.point}'),
                  QButton(
                    onTap: controller.whatsappOpen,
                    btnText: 'Мүмкіндіктер сатып алу',
                    clr: Colors.cyan,
                    textClr: Colors.white,
                  ),
                  Text(
                    'Менің аккаунтым: ${controller.user.value.iin}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  QButton(
                    onTap: controller.logoutAccount,
                    btnText: 'Шығу',
                    clr: Colors.red,
                    textClr: Colors.white,
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
