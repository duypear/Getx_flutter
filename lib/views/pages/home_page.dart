import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../config/routes/app_routes.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find();
    final CartController cartController = Get.find();
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
        actions: [
          IconButton(
            tooltip: 'Chuyển giao diện',
            onPressed: () => themeController.toggle(),
            icon: Obx(
              () => Icon(
                themeController.isDark.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            ),
          ),
          IconButton(
            icon: Obx(
              () => Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.shopping_cart),
                  if (cartController.totalItems > 0)
                    Positioned(
                      right: -6,
                      top: -6,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '${cartController.totalItems}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            onPressed: () => Get.toNamed(AppRoutes.cart),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: (v) => productController.query.value = v,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                final items = productController.filteredProducts;
                if (items.isEmpty) {
                  return const Center(child: Text('Không tìm thấy sản phẩm'));
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // ✅ Đổi từ 2 -> 4 cột
                      childAspectRatio: 0.7, // ✅ Điều chỉnh tỉ lệ card
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: items.length,
                    itemBuilder: (_, index) {
                      final product = items[index];
                      return ProductCard(
                        product: product,
                        onTap: () => Get.toNamed(
                          AppRoutes.productDetail,
                          arguments: product,
                        ),
                        onAdd: () => cartController.addToCart(product),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
