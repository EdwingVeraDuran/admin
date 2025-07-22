import 'package:admin/features/brands/domain/entities/brand.dart';

sealed class BrandEvent {}

class CreateBrand extends BrandEvent {
  final Brand brand;

  CreateBrand(this.brand);
}

class ReadBrands extends BrandEvent {}

class SearchBrands extends BrandEvent {
  final String query;

  SearchBrands(this.query);
}

class UpdateBrand extends BrandEvent {
  final Brand brand;

  UpdateBrand(this.brand);
}

class DeleteBrand extends BrandEvent {
  final String id;

  DeleteBrand(this.id);
}

class ChangePageSize extends BrandEvent {
  final int pageSize;

  ChangePageSize(this.pageSize);
}

class ChangePage extends BrandEvent {
  final int page;

  ChangePage(this.page);
}
