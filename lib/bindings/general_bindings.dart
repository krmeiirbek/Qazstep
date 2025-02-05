import 'package:get/get.dart';

import '../data/repository/home/home_repository.dart';
import '../data/repository/test/test_repository.dart';
import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeRepository());
    Get.put(TestRepository());
    Get.put(NetworkManager());
  }
}
