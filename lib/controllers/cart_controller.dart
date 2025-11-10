import 'package:get/get.dart';
import '../models/product.dart';
import 'package:flutter/material.dart';
class CartController extends GetxController {
  var cartItems = <Product, int>{}.obs;

  void addToCart(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
    Get.snackbar(
      'Đã thêm',
      '${product.name} đã được thêm vào giỏ hàng',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    );
  }

  void removeFromCart(Product product) {
    if (cartItems.containsKey(product) && cartItems[product]! > 1) {
      cartItems[product] = cartItems[product]! - 1;
    } else {
      cartItems.remove(product);
    }
  }

  int get totalPrice => cartItems.entries
      .map((e) => e.key.price * e.value)
      .fold(0, (a, b) => a + b);

  int get totalItems => cartItems.values.fold(0, (a, b) => a + b);

  void clearCart() => cartItems.clear();
}