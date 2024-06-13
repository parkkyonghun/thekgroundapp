import 'package:attendance/constants/assets.dart';
import 'package:attendance/domain/cartViewModel.dart';
import 'package:attendance/models/dto/cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CartItemWidget extends StatelessWidget {
  final CartItem item;
  CartItemWidget({super.key, required this.item});

  final ShoppingCartViewModel cartViewModel = Get.find<ShoppingCartViewModel>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => {Get.toNamed('/details', arguments: item)},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffE9F5FA)),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: CachedNetworkImage(
                  imageUrl: item.imagefrontsmallurl!,
                  width: 40,
                  height: 40,
                  filterQuality: FilterQuality.none,
                  //fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            )),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productname ?? "????",
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("${item.price ?? "10da"} / ${item.quantity}",
                      style: const TextStyle(
                          color: Color(0xffFF324B),
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffE9F5FA),
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (() {
                        cartViewModel.addToCart(item);
                      }),
                      child: Image.asset(
                        Assets.imagesAddIcon,
                        width: 28,
                        height: 28,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      item.itemQuantity.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        //color: Colors.black
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        cartViewModel.removeFromCart(item);
                      },
                      child: Image.asset(
                        Assets.imagesRemoveIcon,
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
