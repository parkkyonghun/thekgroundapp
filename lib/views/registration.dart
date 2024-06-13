import 'package:attendance/constants/assets.dart';
import 'package:attendance/views/common_widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
                        scale: 4.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Enter your mobile number",
                    //textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "We will send you a verification code",
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Get.theme.colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold, /*color: Colors.black*/
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        constraints: BoxConstraints.loose(const Size.fromHeight(80)),
                        border: InputBorder.none,
                        hintText: "0123456789",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Get.theme.colorScheme.primary,
                            fontWeight: FontWeight.bold),
                        //contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        prefix: Text(
                          "+213",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Get.theme.primaryColor),
                        ),
                      )),
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
                        onPressed: () {
                          Get.offAllNamed('/dashboard');
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
