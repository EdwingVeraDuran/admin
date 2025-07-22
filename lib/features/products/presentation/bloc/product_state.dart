import 'package:admin/features/products/domain/entities/product.dart';

sealed class ProductState {}

class ProductsInitial extends ProductState {}

class ProductsLoading extends ProductState {}

class ProductsList extends ProductState {
  final List<Product> products;
  final int page;
  final int pageSize;
  final int totalPages;

  ProductsList(
    this.products, {
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });
}

class ProductsEmpty extends ProductState {}

class ProductsError extends ProductState {
  final String message;

  ProductsError(this.message);
}
