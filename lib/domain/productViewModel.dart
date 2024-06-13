import 'package:attendance/models/dto/product.dart';
import 'package:attendance/models/product_repo_Impl.dart';
import 'package:attendance/utils/myStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductViewModel extends GetxController {
  final ProductRepository _productRepository;
  ProductViewModel({required ProductRepository productRepositoryImpl})
      : _productRepository = productRepositoryImpl;

  final Rx<MyState> _currentState = MyState().obs;
  MyState get currentState => _currentState.value;

  final RxList<Product> _productList = <Product>[].obs;
  List<Product> get productList => _productList;

  RxInt page = 1.obs;

  Future<void> getAllProductList(int page) async {
    try {
      final productList =
          await _productRepository.getAllProductList(page: page);
      _currentState.value = LoadingState();

      if (productList.isEmpty) {
        // Set state to EmptyDataState if the result is empty
        _currentState.value = FailureState('Data is empty');
      } else {
        // Update state to LoadedState with data
        _currentState.value = LoadedState(productList);
        _productList.value = productList;
      }
    } catch (e) {
      print('Error fetching data in viewModel: $e');
      // Update state to FailureState with error message
      _currentState.value = FailureState('An error occurred');
    }
  }

  Future<void> getProductById(BigInt id) async {
    try {
      // Simulating data loading
      final product = await _productRepository.getProductByid(id: id);
      _currentState.value = LoadedState(product);
    } catch (e) {
      // Update state to FailureState with error message
      _currentState.value = FailureState('An error occurred');
    }
    return;
  }

  static final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    //getAllProductList(page.value);
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          page.value < 11) {
        // Check if existing data is available
        if (_currentState.value is LoadedState) {
          // If data exists, append new items to the existing list
          List<Product> existingList =
              (_currentState.value as LoadedState).data;
          page.value += 1;

          final newList =
              await _productRepository.getAllProductList(page: page.value);

          final updatedList = existingList + newList;
          //_currentState.value = EmptyDataState();
          (_currentState.value as LoadedState).data = updatedList.toList();
          //_currentState.value = LoadedState(updatedList);
          _productList.value = updatedList;
          print("updated list length =>${updatedList.length}");
          return;
        }
      }
    });
  }

  @override
  void onClose() {
    _currentState.close();
    scrollController.dispose();
    super.onClose();
  }
}
