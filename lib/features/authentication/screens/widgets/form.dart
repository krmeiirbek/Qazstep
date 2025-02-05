import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qazstep/utils/formatters/formatter.dart';

import '../../../../common/widgets/qbutton.dart';
import '../../../../data/repository/authentication/authentication_repository.dart';
import '../../controllers/authentication_controller.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationController());
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Container(
        padding: EdgeInsets.all(20.h),
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.iinController,
                        keyboardType: TextInputType.number,
                        // Тек сандарды ғана қабылдайды және ұзындығы 12 таңба болады.
                        validator: TFormatter.checkIIN,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(12),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'ЖСН (ИИН) енгізіңіз',
                          hintText: 'Мысалы: 123456789012',
                        ),
                        readOnly: controller.showSigninField.value || controller.showSignupField.value,
                      ),
                      (controller.showSigninField.value || controller.showSignupField.value)
                          ? Container()
                          : QButton(
                              onTap: controller.checkInFirebaseUser,
                              btnText: 'Ары қарай',
                              clr: Colors.blue,
                              textClr: Colors.white,
                            ),
                      (controller.showSigninField.value || controller.showSignupField.value)
                          ? QButton(
                              onTap: controller.back,
                              btnText: 'ЖСН (ИИН) өзгертемін',
                              clr: Colors.blue,
                              textClr: Colors.white,
                            )
                          : Container(),
                    ],
                  ),
                ),
                controller.showSignupField.value
                    ? Form(
                        key: controller.formKeyRegister,
                        child: Column(
                          children: [
                            // Password Field
                            TextFormField(
                              controller: controller.passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Құпия сөз',
                                hintText: 'Құпия сөзді енгізіңіз',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Құпия сөзді енгізіңіз';
                                }
                                if (value.length < 6) {
                                  return 'Құпия сөз кемінде 6 символ болу керек';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            // Confirm Password Field
                            TextFormField(
                              controller: controller.confirmController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Құпия сөзді сәйкестендіру',
                                hintText: 'Құпия сөзді қайталаңыз',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Құпия сөзді қайталаңыз';
                                }
                                if (value != controller.passwordController.text) {
                                  return 'Құпия сөз сәйкес келмейді';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            QButton(
                              onTap: controller.registerIINtoFirebase,
                              btnText: 'Тіркелу',
                              clr: Colors.blue,
                              textClr: Colors.white,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                controller.showSigninField.value
                    ? Form(
                        key: controller.formKeyLogin,
                        child: Column(
                          children: [
                            // Password Field
                            TextFormField(
                              controller: controller.loginPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Құпия сөз',
                                hintText: 'Құпия сөзді енгізіңіз',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Құпия сөзді енгізіңіз';
                                }
                                if (value.length < 6) {
                                  return 'Құпия сөз кемінде 6 символ болу керек';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            QButton(
                              onTap: controller.login,
                              btnText: 'Кіру',
                              clr: Colors.blue,
                              textClr: Colors.white,
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            )),
      ),
    );
  }
}
