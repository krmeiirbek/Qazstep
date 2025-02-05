import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/authentication/authentication_repository.dart';
import '../../../data/repository/home/home_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/formatters/formatter.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get instance => Get.find();

  final authRepository = AuthenticationRepository.instance;
  final homeRepository = HomeRepository.instance;
  final formKey = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  final formKeyLogin = GlobalKey<FormState>();
  final iinController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final showSignupField = false.obs;
  final showSigninField = false.obs;

  void back() {
    showSigninField.value = false;
    showSignupField.value = false;
    update();
  }

  void checkInFirebaseUser() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    try {
      TFullScreenLoader.openLoadingDialog('Сізді базадан тексеріп жатырмыз', TImages.loading);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      final result = await authRepository.checkUserInFirebaseStorage(iinController.text);
      if (result) {
        showSigninField.value = true;
        showSignupField.value = false;
      } else {
        showSigninField.value = false;
        showSignupField.value = true;
      }
      update();
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Базада қате пайда болды', message: e.toString());
    }
  }

  void registerIINtoFirebase() async {
    if (formKeyRegister.currentState?.validate() == false) {
      return;
    }
    try {
      TFullScreenLoader.openLoadingDialog('Күте тұрыңыз, тіркеліп жатырмыз!', TImages.loading);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      final userCredentials = await authRepository.signupWithEmailPassword('${iinController.text}@qazstep.kz', passwordController.text);
      await homeRepository.saveUserRecordCredentials(userCredentials, iinController.text, passwordController.text);
      TFullScreenLoader.stopLoading();
      authRepository.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Базада қате пайда болды', message: e.toString());
    }
  }

  void login() async {
    if (formKeyLogin.currentState?.validate() == false) {
      return;
    }
    try {
      TFullScreenLoader.openLoadingDialog('Күте тұрыңыз, кіріп жатырмыз!', TImages.loading);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await authRepository.signinWithEmailPassword('${iinController.text}@qazstep.kz', loginPasswordController.text);
      TFullScreenLoader.stopLoading();
      authRepository.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Базада қате пайда болды', message: e.toString());
    }
  }

  @override
  void dispose() {
    iinController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }
}
