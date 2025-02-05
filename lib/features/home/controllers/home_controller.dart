import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../data/repository/authentication/authentication_repository.dart';
import '../../../data/repository/home/home_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../../../utils/popups/show_dialogs.dart';
import '../models/user/user_model.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final homeRepository = HomeRepository.instance;
  final user = UserModel.empty().obs;
  final loading = false.obs;
  final phoneNumber = ''.obs;
  final point = ''.obs;

  @override
  void onInit() {
    fetchUserRecord();
    super.onInit();
  }

  Future<void> fetchUserRecord() async {
    try {
      loading.value = true;
      final user = await homeRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Қателік болды', message: e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> whatsappOpen() async {
  final link = WhatsAppUnilink(
    phoneNumber: '+77475551101',
    text: "Account: ${user.value.iin}\nID: ${user.value.id}\nТест тапсыру мүмкіндігін алғым келеді",
  );
  await launchUrl(link.asUri());
}

  void logoutAccount() {
    try {
      ShowDialogs.logoutShowDialog(
        title: 'Шығу',
        onPressed: () async => AuthenticationRepository.instance.logout(),
        middleText: 'Сенімдісізбе?',
      );
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Қате болды', message: e.toString());
    }
  }
}