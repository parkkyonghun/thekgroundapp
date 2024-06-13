
import 'package:attendance/core/cache_manager.dart';
import 'package:get/get.dart';

class AuthenticationManager extends GetxController with CacheManager {
      final isLogged = false.obs;

      @override
      void onInit() {
        super.onInit();
        checkLoginStatus();
      }

      void logOut(){
        isLogged.value = false;
        removeToken();
      }

      void login(String? token) async{
        isLogged.value = true;
        saveToken(token);
      }

      void checkLoginStatus() {
        final token = getToken();
        if(token != null){
          isLogged.value = true;
        }

      }

}