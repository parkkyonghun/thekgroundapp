import 'package:attendance/constants/assets.dart';
import 'package:attendance/core/authentication_manager.dart';
import 'package:attendance/views/onboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final AuthenticationManager authManager = Get.put(AuthenticationManager());
  
  Future<void> initializeSettings() async{
    authManager.checkLoginStatus();
    print("init : =====> ${authManager.isLogged.value}");
    //Simulate other service for 3 seconds
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError) {
            return errorView(snapshot);
          } else {
            return const OnBoard();
          }
        }
      },
    );
  }
  
    Scaffold errorView(AsyncSnapshot<Object?> snapshot){
      return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
    }
    
    Scaffold waitingView(){
      return Scaffold(
        body: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                Assets.imagesAppIcon,
                scale: 2.5,
              ),
            ),
            const Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator(),),
            const Text('Loading...')
          ],
          ),
        ),
      );
    }
    
    // Future.delayed(
    //   const Duration(seconds: 3),
    //   () => Get.offAll(() => const WelcomeScreen()),
    // );

    // return Scaffold(
    //   backgroundColor: Get.theme.primaryColor,
    //   body: Center(
    //     child: Image.asset(
    //       Assets.imagesAppIcon,
    //       scale: 2.5,
    //     ),
    //   ),
    // );
  }

