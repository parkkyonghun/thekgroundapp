import 'package:attendance/models/dto/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedProfileKey = 'CACHED_PROFILE_ITEM';

abstract class ProfileLocalStorageRepo {
  Future<bool> getProfile({required Profile profile});

}

class ProfileLocalStorageImpl implements ProfileLocalStorageRepo {
  final SharedPreferences _sharedPref;
  final String _key;

  ProfileLocalStorageImpl({
    required SharedPreferences sharedPreferences,
  })  : _sharedPref = sharedPreferences,
        _key = cachedProfileKey;

  @visibleForTesting
  static String getKeyToList(int page) {
    return '${cachedProfileKey}_$page';
  }


  // @override
  // Future<bool> updateCartItem({required CartItem cartItem}) {
  //   throw UnimplementedError();
  // }
  //
  // Future<String?> getProfile(Profile profile) async {
  //   return _sharedPref.getString('Profile');
  // }

  Future<bool> saveCartItem({required Profile profile}) {
    // TODO: implement saveCartItem
    throw UnimplementedError();
  }

  @override
  Future<bool> getProfile({required Profile profile}) {
    // TODO: implement getProfile
    throw UnimplementedError();
  }
}
