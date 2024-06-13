import 'package:attendance/constants/assets.dart';
import 'package:attendance/domain/LogInViewModel.dart';
import 'package:attendance/views/common_widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController {
  var pwdVisible = false.obs;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }
}


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    final PasswordController pwdController = Get.put(PasswordController());

    final TextEditingController emailTextController = TextEditingController();
    final TextEditingController passwordTextController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: MyAppBar(
          leading:
              InkResponse(onTap: () => Get.back(), child: const BackButtonIcon())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Get.theme.cardColor,
                    radius: 36,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        Assets.imagesAppIcon,
                        scale: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Login to your Working Time",
                    //textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "The K Ground ERP",

                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Get.theme.colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Shortcuts(shortcuts: const <ShortcutActivator, Intent>{
                    SingleActivator(LogicalKeyboardKey.space) : NextFocusIntent(),
                  }, child: FocusTraversalGroup(
                    child: Form(
                      key: controller.formKey,
                      autovalidateMode: AutovalidateMode.always,
                      onChanged: () => Form.of(primaryFocus!.context!).save(),
                      child: Wrap(
                        spacing: 20.0,
                        children:[
                          TextFormField(
                            controller: emailTextController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email, color: Colors.blue[700],),
                              constraints: BoxConstraints.loose(const Size.fromHeight(80)),
                              hintText: "Enter your email",
                              hintStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            validator: (email) => controller.validateEmail(email),
                          ),
                          const SizedBox(height: 20,),
                          Obx(() => TextFormField(
                              controller: passwordTextController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: pwdController.pwdVisible.value,
                              autocorrect: false,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                constraints: BoxConstraints.loose(const Size.fromHeight(80)),
                                hintText: "Enter your password",
                                hintStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                                prefixIcon: Obx(() => IconButton(
                                    icon: Icon(pwdController.pwdVisible.value ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).primaryColorDark),
                                    onPressed: () {
                                      pwdController.pwdVisible.value = !pwdController.pwdVisible.value;
                                    }
                                  ),
                                )
                              ),
                              validator: (pwd) => controller.validatePassword(pwd),
                            ),
                          )
                        ]
                      ),
                    ),
                  ))

                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: ElevatedButton(
                        onPressed: () async {
                          await controller.onLogin(email:emailTextController.text, password: passwordTextController.text);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          shape: const StadiumBorder(),
                          backgroundColor: Get.theme.primaryColor,
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              "By clicking on “Continue” you are agreeing to our ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Get.theme.colorScheme.primary,
                              fontSize: 12),
                          children: const <TextSpan>[
                            TextSpan(
                                text: "terms of use",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ],
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
