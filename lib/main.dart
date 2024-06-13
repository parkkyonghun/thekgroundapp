import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/myTheme.dart';
import 'package:attendance/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await GetStorage.init();

  // final AuthService authService = AuthService(AppConstants.BASE_URL);
  // Get.put<LoginController>(LoginController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return ThemeProvider(
      initTheme: AppThemes.lightTheme1,
      builder: (context, myTheme){
        return GetMaterialApp(
          title: "The K Ground ERP",
          theme: myTheme,
          initialRoute: "/splash",
          getPages: MyRoutes.pages,
        );
      },
    );
  }
}

