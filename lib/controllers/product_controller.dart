import 'package:get/get.dart';
import '../models/product.dart';
import '../data/sample_products.dart';

class ProductController extends GetxController {
  var query = ''.obs;

  // Gọi dữ liệu từ file sample_products
  var products = sampleProducts.obs;

  List<Product> get filteredProducts {
    final q = query.value.toLowerCase().trim();
    if (q.isEmpty) return products;
    return products.where((p) => p.name.toLowerCase().contains(q)).toList();
  }
}
