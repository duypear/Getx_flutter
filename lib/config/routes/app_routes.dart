import 'package:get/get.dart';
import '../../views/pages/home_page.dart';
import '../../views/pages/product_detail_page.dart';
import '../../views/pages/cart_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String productDetail = '/detail';
  static const String cart = '/cart';

  static final pages = [
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: productDetail, page: () => const ProductDetailPage()),
    GetPage(name: cart, page: () => const CartPage()),
  ];
}