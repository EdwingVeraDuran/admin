import 'dart:io';

import 'package:admin/core/models/paginated_data.dart';
import 'package:admin/features/products/domain/entities/product.dart';
import 'package:admin/features/products/domain/repos/product_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProductRepo implements ProductRepo {
  final productsTable = Supabase.instance.client.from('products');
  final productsImages = Supabase.instance.client.storage.from(
    'product-images',
  );

  @override
  Future<void> createProduct(Product product, File image) async {
    try {
      final response = await productsTable
          .insert(product.toMap())
          .select('id')
          .single();
      await uploadProductImage(response['id'], image);
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

  @override
  Future<PaginatedData<Product>> readProducts(int page, int pageSize) async {
    try {
      final from = (page - 1) * pageSize;
      final to = from + pageSize - 1;

      final response = await productsTable
          .select('*, brand:brands(*), category: categories(*)')
          .range(from, to);
      final count = await productsTable.count();
      return PaginatedData<Product>(
        data: response.map((p) => Product.fromMap(p)).toList(),
        total: count,
      );
    } catch (e) {
      throw Exception('Error reading products: $e');
    }
  }

  @override
  Future<PaginatedData<Product>> searchProducts(
    String query,
    int page,
    int pageSize,
  ) async {
    try {
      final from = (page - 1) * pageSize;
      final to = from + pageSize - 1;

      final response = await productsTable
          .select('*, brand:brands(*), category: categories(*)')
          .or('name.ilike.%$query%,code.ilike.%$query%')
          .range(from, to);
      final count = await productsTable.count();
      return PaginatedData<Product>(
        data: response.map((p) => Product.fromMap(p)).toList(),
        total: count,
      );
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }

  @override
  Future<void> updateProduct(Product product, [File? image]) async {
    try {
      await productsTable.update(product.toMap()).eq('id', product.id!);

      if (image != null) await updateProductImage(product.id!, image);
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await productsTable.delete().eq('id', id);
      await deleteProductImage(id);
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

  @override
  Future<void> uploadProductImage(String id, File image) async {
    try {
      await productsImages.upload(id, image);
    } catch (e) {
      throw Exception('Error uploading product image: $e');
    }
  }

  @override
  Future<void> updateProductImage(String id, File image) async {
    try {
      await productsImages.update(id, image);
    } catch (e) {
      throw Exception('Error updating product image: $e');
    }
  }

  @override
  Future<void> deleteProductImage(String imagePath) async {
    try {
      await productsImages.remove([imagePath]);
    } catch (e) {
      throw Exception('Error deleting product image: $e');
    }
  }

  @override
  String getImageUrl(String id) {
    try {
      return productsImages.getPublicUrl(
        id,
        transform: TransformOptions(width: 300, height: 300),
      );
    } catch (e) {
      throw Exception('Error retrieving product image url: $e');
    }
  }
}
