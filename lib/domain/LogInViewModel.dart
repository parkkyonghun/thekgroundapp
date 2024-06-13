import 'dart:async';

import 'package:attendance/constants/appConstants.dart';
import 'package:attendance/core/authentication_manager.dart';
import 'package:attendance/models/dto/profile.dart';
import 'package:attendance/models/dto/response.dart';
import 'package:attendance/models/source/remote/authService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final AuthService authService;
  late final AuthenticationManager authManger;
  final username = RxString('');
  final Rx photo = RxString('');
  final Rx userEmail = RxString('');
  RxMap employee = {}.obs;
  RxMap position = {}.obs;

  // LoginController(AuthService authService);

  // LoginController(this.authService);

  validateEmail(String? email) {
    if (!GetUtils.isEmail(email ?? '')) {
      return 'Email is not valid';
    }
    return null;
  }

  validatePassword(String? pwd) {
    if (!GetUtils.isLengthGreaterThan(pwd, 3)) {
      return 'Please enter the password';
    } else if (GetUtils.isNullOrBlank(pwd ?? '') == true) {
      return 'Password is not valid';
    }
    return null;
  }

  @override
  void onInit(){
    super.onInit();
    authService = Get.put(AuthService(AppConstants.BASE_URL));
    authManger = Get.put(AuthenticationManager());
  }


  Future onLogin({required String email, required String password}) async {
    // Create login data
    LoginData loginData = LoginData(email, password, true);
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";

    // Validate form fields
    if (formKey.currentState!.validate()) {
      // If validation passes, attempt login
      try {
        final response = await loginUser(loginData);
        if (response.success) {
          // Handle successful login (e.g., navigate to another screen, show a success message, etc.)
          Get.snackbar('Login Successfully', response.message.toString());
          // Get.offAllNamed('/dashboard');
          authManger.login(token);
          //data

          Map<String, dynamic> profileMap = response.result;
          Profile myProfile = Profile.fromMap(profileMap);
          username.value = myProfile.name!.toString();
          userEmail.value = myProfile.email!.toString();
          photo.value = myProfile.photo ?? '';
          position.value = profileMap['position']!;
          employee.value = profileMap['employee']!;

          // You can perform additional actions here such as navigation or saving user data
        } else {
          // Handle login failure (e.g., show an error message to the user)
          Get.snackbar('Login Failed', response.message);
          print('Login failed: ${response.message}');
        }
      } catch (e) {
        // Handle unexpected errors
        Get.snackbar('Error', 'Unexpected error occurred. Please try again.');
        print('Unexpected error: $e');
      }
    }
  }

  Future<LoginResponse> loginUser(LoginData loginData) async {
    try {
      final response = await authService.login(loginData);
      return response;
    } on Exception catch (e) {
      throw Exception('Failed to login: $e'); // Handle login failure
    } catch (e) {
      throw Exception('Unexpected error: $e'); // Handle any other exceptions
    }
  }
}



