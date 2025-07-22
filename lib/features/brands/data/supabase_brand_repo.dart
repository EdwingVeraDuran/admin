import 'package:admin/core/models/paginated_data.dart';
import 'package:admin/features/brands/domain/entities/brand.dart';
import 'package:admin/features/brands/domain/repos/brand_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseBrandRepo implements BrandRepo {
  final brandsTable = Supabase.instance.client.from('brands');

  @override
  Future<void> createBrand(Brand brand) async {
    try {
      await brandsTable.insert(brand.toMap());
    } catch (e) {
      throw Exception('Error creating brand: $e');
    }
  }

  @override
  Future<PaginatedData<Brand>> readBrands(int page, int pageSize) async {
    try {
      final from = (page - 1) * pageSize;
      final to = from + pageSize - 1;
      final response = await brandsTable.select().range(from, to);
      final count = await brandsTable.count();
      return PaginatedData<Brand>(
        data: response.map((b) => Brand.fromMap(b)).toList(),
        total: count,
      );
    } catch (e) {
      throw Exception('Error reading brands: $e');
    }
  }

  @override
  Future<List<Brand>> readAllBrands() async {
    try {
      final response = await brandsTable.select();
      return response.map((b) => Brand.fromMap(b)).toList();
    } catch (e) {
      throw Exception('Error reading all brands: $e');
    }
  }

  @override
  Future<PaginatedData<Brand>> searchBrands(
    String query,
    int page,
    int pageSize,
  ) async {
    try {
      final from = (page - 1) * pageSize;
      final to = from + pageSize - 1;
      final response = await brandsTable
          .select()
          .ilike('name', '%$query%')
          .range(from, to);
      final count = await brandsTable.count();
      return PaginatedData<Brand>(
        data: response.map((b) => Brand.fromMap(b)).toList(),
        total: count,
      );
    } catch (e) {
      throw Exception('Error searching brand: $e');
    }
  }

  @override
  Future<void> updateBrand(Brand brand) async {
    try {
      await brandsTable.update(brand.toMap()).eq('id', brand.id!);
    } catch (e) {
      throw Exception('Error updating brand: $e');
    }
  }

  @override
  Future<void> deleteBrand(String id) async {
    try {
      await brandsTable.delete().eq('id', id);
    } catch (e) {
      throw Exception('Error deleting brand: $e');
    }
  }
}
