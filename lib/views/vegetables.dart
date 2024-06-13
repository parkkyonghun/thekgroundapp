
import 'package:attendance/constants/assets.dart';
import 'package:attendance/domain/productViewModel.dart';
import 'package:attendance/models/dto/product.dart';
import 'package:attendance/utils/myStates.dart';
import 'package:attendance/views/common_widgets/appBar.dart';
import 'package:attendance/views/common_widgets/loading_indicator.dart';
import 'package:attendance/views/common_widgets/search_text_field.dart';
import 'package:attendance/views/common_widgets/vegetable_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VegetablesScreen extends StatefulWidget {
  const VegetablesScreen({super.key});

  @override
  State<VegetablesScreen> createState() => _VegetablesScreenState();
}

class _VegetablesScreenState extends State<VegetablesScreen> {
  final ProductViewModel productViewModel = Get.find<ProductViewModel>();
  bool isLoading = true;
  late List<Product> _productList;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 340), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: SearchTextField(
              hint: "Search products...",
              //argument: _productList,
              readOnly: true,
            ),
          ),
          leading:
              InkResponse(onTap: () => Get.back(), child: const BackButtonIcon())),
      body: isLoading
          ? const LoadingIndicator(width: 34, height: 34)
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () {
                  // Use the productViewModel.currentState to determine the state
                  if (productViewModel.currentState is LoadingState) {
                    // Loading state, show a loading indicator or placeholder
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        mainAxisExtent: 225,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffdddddd),
                              border: Border.all(color: const Color(0xffF1F1F5)),
                              borderRadius: BorderRadius.circular(8)),
                          width: (MediaQuery.of(context).size.width / 2) - 34,
                        );
                      },
                      itemCount: 6,
                    );
                  } else if (productViewModel.currentState is LoadedState) {
                    // Loaded state, display the product list
                    _productList =
                        (productViewModel.currentState as LoadedState).data;
                    //bool isLoadingMore = false;
                    return DefaultTabController(
                      length: 3,
                      child: GridView.builder(
                        controller: ProductViewModel.scrollController,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          mainAxisExtent: 210,
                        ),
                        itemBuilder: (context, index) {
                          if (index < _productList.length) {
                            print(
                                "product list in ui length =>${_productList.length}");
                            return VegetableCardWidget(
                              product: _productList[index],
                            );
                          } else if (index == _productList.length) {
                            // Render loading indicator
                            print(
                                "product list in ui length =>${_productList.length}");
                            return const Center(child: CircularProgressIndicator());
                          }
                          print(
                              "product list in ui length =>${_productList.length}");
                          return const SizedBox.shrink();
                          // Customize this part to extract data from your product model
                        },
                        itemCount: _productList.length +
                            (productViewModel.page.value < 8 ? 1 : 0),
                      ),
                    );
                  } else if (productViewModel.currentState is FailureState) {
                    // Failure state, show an error message
                    final errorMessage =
                        (productViewModel.currentState as FailureState)
                            .errorMessage;
                    return Center(
                      child: Column(
                        children: [
                          Image.asset(
                            Assets.imagesEmptyList,
                            scale: 4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(errorMessage),
                          const SizedBox(
                            height: 8,
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                {productViewModel.getAllProductList(1)},
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              shape: const StadiumBorder(),
                              backgroundColor: Get.theme.primaryColor,
                            ),
                            child: const Text(
                              "Refresh",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    // Handle other states as needed
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        mainAxisExtent: 225,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffdddddd),
                              border: Border.all(color: const Color(0xffF1F1F5)),
                              borderRadius: BorderRadius.circular(8)),
                          width: (MediaQuery.of(context).size.width / 2) - 34,
                        );
                      },
                      itemCount: 6,
                    );
                  }
                },
              ),
            ),
    );
  }
}
