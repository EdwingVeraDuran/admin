import 'dart:io';

import 'package:admin/core/models/paginated_data.dart';
import 'package:admin/features/products/domain/entities/product.dart';

abstract class ProductRepo {
  Future<void> createProduct(Product product, File image);
  Future<PaginatedData<Product>> readProducts(int page, int pageSize);
  Future<PaginatedData<Product>> searchProducts(
    String query,
    int page,
    int pageSize,
  );
  Future<void> updateProduct(Product product, File image);
  Future<void> deleteProduct(String id);
  Future<void> uploadProductImage(String id, File image);
  Future<void> updateProductImage(String id, File image);
  Future<void> deleteProductImage(String id);
  String getImageUrl(String id);
}
