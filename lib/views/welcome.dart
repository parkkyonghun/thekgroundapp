import 'package:attendance/constants/assets.dart';
import 'package:attendance/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common_widgets/appBar.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
            image: AssetImage(Assets.imagesWelcomeBg),
            fit: BoxFit.cover,
          ))),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 44,
                  ),
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
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text(
                      "Get your groceries delivered to your home",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      "The best delivery app in town for delivering your daily fresh groceries",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Get.theme.colorScheme.primary),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          shape: const StadiumBorder(),
                          backgroundColor: Get.theme.primaryColor,
                        ),
                        child: const Text(
                          "Shop now",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
