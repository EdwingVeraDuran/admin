import 'package:admin/core/models/paginated_data.dart';
import 'package:admin/features/categories/domain/entities/category.dart';
import 'package:admin/features/categories/domain/repos/category_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCategoryRepo implements CategoryRepo {
  final categoriesTable = Supabase.instance.client.from('categories');

  @override
  Future<void> createCategory(Category category) async {
    try {
      await categoriesTable.insert(category.toMap());
    } catch (e) {
      throw Exception('Error creating category: $e');
    }
  }

  @override
  Future<PaginatedData<Category>> readCategories(int page, int pageSize) async {
    try {
      final from = (page - 1) * pageSize;
      final to = from + pageSize - 1;

      final response = await categoriesTable.select().range(from, to);
      final count = await categoriesTable.count();
      return PaginatedData<Category>(
        data: response.map((c) => Category.fromMap(c)).toList(),
        total: count,
      );
    } catch (e) {
      throw Exception('Error reading categories: $e');
    }
  }

  @override
  Future<List<Category>> readAllCategories() async {
    try {
      final response = await categoriesTable.select();
      return response.map((c) => Category.fromMap(c)).toList();
    } catch (e) {
      throw Exception('Error reading all categories: $e');
    }
  }

  @override
  Future<PaginatedData<Category>> searchCategories(
    String query,
    int page,
    int pageSize,
  ) async {
    try {
      final from = (page - 1) * pageSize;
      final to = from + pageSize - 1;

      final response = await categoriesTable
          .select()
          .ilike('name', '%$query%')
          .range(from, to);
      final count = await categoriesTable.count();
      return PaginatedData<Category>(
        data: response.map((c) => Category.fromMap(c)).toList(),
        total: count,
      );
    } catch (e) {
      throw Exception('Error searching categories: $e');
    }
  }

  @override
  Future<void> updateCategory(Category category) async {
    try {
      await categoriesTable.update(category.toMap()).eq('id', category.id!);
    } catch (e) {
      throw Exception('Error updating category: $e');
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await categoriesTable.delete().eq('id', id);
    } catch (e) {
      throw Exception('Error deleting category: $e');
    }
  }
}
