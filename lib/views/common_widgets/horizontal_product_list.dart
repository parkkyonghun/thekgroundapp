import 'package:attendance/constants/assets.dart';
import 'package:attendance/domain/productViewModel.dart';
import 'package:attendance/models/dto/product.dart';
import 'package:attendance/utils/myStates.dart';
import 'package:attendance/views/common_widgets/vegetable_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalProductList extends StatefulWidget {
  final int page;
  final bool isSecondList;
  const HorizontalProductList({
    super.key,
    required this.page,
    required this.isSecondList,
  });

  @override
  State<HorizontalProductList> createState() => _HorizontalProductListState();
}

class _HorizontalProductListState extends State<HorizontalProductList> {
  final ProductViewModel productViewModel = Get.find<ProductViewModel>();
  @override
  void initState() {
    super.initState();
    productViewModel.getAllProductList(widget.page);
  }

  @override
  Widget build(BuildContext context) {
    // Static part of the widget that doesn't depend on the observable state
    final staticWidget = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 234, 234, 234),
                border: Border.all(color: const Color(0xffF1F1F5)),
                borderRadius: BorderRadius.circular(8),
              ),
              width: (MediaQuery.of(context).size.width / 2) - 34,
            ),
            const SizedBox(width: 8),
          ],
        );
      },
    );

    return RepaintBoundary(
      child: Obx(() {
        if (productViewModel.currentState is LoadingState) {
          // Loading state, show the static part
          return staticWidget;
        } else if (productViewModel.currentState is LoadedState) {
          // Loaded state, display the product list
          List<Product> productList =
              (productViewModel.currentState as LoadedState).data;
          if (widget.isSecondList) {
            productList = productList.reversed.toList();
          }
          print("loaded data loaded");
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length > 20 ? 20 : productList.length,
            itemBuilder: (context, index) {
              print("listView rebuild again");
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      VegetableCardWidget(
                        product: productList[index],
                      ),
                      const SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                ],
              );
            },
          );
        } else if (productViewModel.currentState is FailureState) {
          // Failure state, show an error message
          final errorMessage =
              (productViewModel.currentState as FailureState).errorMessage;
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
                      {productViewModel.getAllProductList(widget.page)},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
          return staticWidget;
        }
      }),
    );
  }
}
