import 'package:attendance/core/authentication_manager.dart';
import 'package:attendance/views/home.dart';
import 'package:attendance/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationManager authManager = Get.put(AuthenticationManager());
    return Obx(() {
      print("authManager.isLogged.value : ${authManager.isLogged.value}");
      return authManager.isLogged.value ? const HomeScreen() : const LoginScreen();
    });
  }
}
