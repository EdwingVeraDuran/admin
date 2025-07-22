import 'package:admin/core/models/paginated_data.dart';
import 'package:admin/features/brands/domain/entities/brand.dart';

abstract class BrandRepo {
  Future<void> createBrand(Brand brand);
  Future<PaginatedData<Brand>> readBrands(int page, int pageSize);
  Future<List<Brand>> readAllBrands();
  Future<PaginatedData<Brand>> searchBrands(
    String query,
    int page,
    int pageSize,
  );
  Future<void> updateBrand(Brand brand);
  Future<void> deleteBrand(String id);
}
