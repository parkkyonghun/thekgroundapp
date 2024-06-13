import 'package:attendance/core/authentication_manager.dart';
import 'package:attendance/domain/LogInViewModel.dart';
import 'package:attendance/domain/cartViewModel.dart';
import 'package:attendance/domain/categorieViewModel.dart';
import 'package:attendance/domain/productViewModel.dart';
import 'package:attendance/models/product_repo_Impl.dart';
import 'package:attendance/models/shopingCart_repo_impl.dart';
import 'package:attendance/models/source/local/cart_local_storage.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/appConstants.dart';
import '../models/source/local/product_local_storage.dart';
import '../models/source/remote/api.dart';


Future initDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  // final AuthService authService = AuthService(AppConstants.BASE_URL);

  Get.lazyPut(() => LocalStorageImpl(sharedPreferences: sharedPreferences));

  Get.lazyPut(() => ApiImpl(AppConstants.BASE_URL));

  Get.lazyPut(() => ProductRepositoryImpl(
        api: Get.find<ApiImpl>(),
        localStorage: Get.find<LocalStorageImpl>(),
      ));

  Get.lazyPut(() => ProductViewModel(
      productRepositoryImpl: Get.find<ProductRepositoryImpl>()));

  Get.lazyPut(() => CartLocalStorageImpl(sharedPreferences: sharedPreferences));

  Get.lazyPut(() => CartRepositoryImpl(
        cartLocalStorage: Get.find<CartLocalStorageImpl>(),
      ));

  Get.lazyPut(() => ShoppingCartViewModel(
      cartRepositoryImpl: Get.find<CartRepositoryImpl>()));

  Get.put<LoginController>(LoginController());
  Get.lazyPut(()=> AuthenticationManager());
  // Get.lazyPut(() => LoginController());
  Get.put(CategorieViewModel());

  // Get.put(LoginController());

  //Get.put(MyGameController());
}

Future<LottieComposition?> customDecoder(List<int> bytes) {
  return LottieComposition.decodeZip(bytes, filePicker: (files) {
    return files.firstWhereOrNull(
        (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
  });
}
