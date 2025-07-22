import 'dart:io';

import 'package:admin/features/products/domain/entities/product.dart';

sealed class ProductEvent {}

class CreateProduct extends ProductEvent {
  final Product product;
  final File image;

  CreateProduct(this.product, this.image);
}

class ReadProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;

  SearchProducts(this.query);
}

class UpdateProduct extends ProductEvent {
  final Product product;
  final File? image;

  UpdateProduct(this.product, this.image);
}

class DeleteProduct extends ProductEvent {
  final String id;

  DeleteProduct(this.id);
}

class ChangePageSize extends ProductEvent {
  final int pageSize;

  ChangePageSize(this.pageSize);
}

class ChangePage extends ProductEvent {
  final int page;

  ChangePage(this.page);
}
