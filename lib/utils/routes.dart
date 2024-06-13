import 'package:attendance/views/dashboard.dart';
import 'package:attendance/views/home.dart';
import 'package:attendance/views/login/login.dart';
import 'package:attendance/views/registration.dart';
import 'package:attendance/views/splash.dart';
import 'package:attendance/views/welcome.dart';
import 'package:get/get.dart';


class MyRoutes {
  static final List<GetPage> pages = [
    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/', page: () => const WelcomeScreen()),
    GetPage(name: '/registration', page: () => const RegistrationScreen()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/dashboard', page: () => const HomeScreen()),
    GetPage(name: '/home', page: () => const DashboardScreen()),
    // GetPage(name: '/categories', page: () => const Categories()),
    // GetPage(name: '/cart', page: () => CartScreen()),
    // GetPage(name: '/profile', page: () => const Profile()),
    // GetPage(name: '/vegetables', page: () => const VegetablesScreen()),
    //GetPage(name: '/search', page: () => VegetablesSearchScreen()),
    // GetPage(name: '/details', page: () => const VegetableDetailScreen()),
    //GetPage(name: '/ArExperience', page: () => ArExperience()),
  ];
}
