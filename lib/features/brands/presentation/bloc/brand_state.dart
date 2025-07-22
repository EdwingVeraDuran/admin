import 'package:admin/features/brands/domain/entities/brand.dart';

sealed class BrandState {}

class BrandsInitial extends BrandState {}

class BrandsLoading extends BrandState {}

class BrandsList extends BrandState {
  final List<Brand> brands;
  final int page;
  final int pageSize;
  final int totalPages;

  BrandsList(
    this.brands, {
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });
}

class BrandsEmpty extends BrandState {}

class BrandsError extends BrandState {
  final String message;

  BrandsError(this.message);
}
