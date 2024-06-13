import 'package:attendance/constants/assets.dart';
import 'package:attendance/models/dto/categorie.dart';
import 'package:attendance/utils/myStates.dart';
import 'package:get/get.dart';

class CategorieViewModel extends GetxController {
  final Rx<MyState> _currentState = MyState().obs;
  MyState get currentState => _currentState.value;

  static List<Categorie> categoriesMockup = [
    Categorie(
        id: '0', name: 'Fish & Seafood', imagefrontsmallurl: Assets.imagesFish),
    Categorie(
        id: '1', name: 'Vegetables', imagefrontsmallurl: Assets.imagesFalafel),
    Categorie(id: '2', name: 'Fruits', imagefrontsmallurl: Assets.imagesBanana),
    Categorie(
        id: '3', name: 'Snacks', imagefrontsmallurl: Assets.imagesIceCream),
    Categorie(
        id: '4',
        name: 'Canned & Spices',
        imagefrontsmallurl: Assets.imagesDish),
    Categorie(
        id: '5', name: 'Pasta, Rice', imagefrontsmallurl: Assets.imagesRice),
    Categorie(
        id: '6',
        name: 'House Supplies',
        imagefrontsmallurl: Assets.imagesSavon),
    Categorie(
        id: '7',
        name: 'Personal Care',
        imagefrontsmallurl: Assets.imagesMakeup),
  ];

  void getAllCategories() {
    _currentState.value = LoadingState();
    Future.delayed(const Duration(seconds: 5))
        .then((value) => _currentState.value = LoadedState(categoriesMockup));
  }
}
