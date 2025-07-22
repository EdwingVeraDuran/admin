import 'package:admin/core/models/paginated_data.dart';
import 'package:admin/features/categories/domain/entities/category.dart';

abstract class CategoryRepo {
  Future<void> createCategory(Category category);
  Future<PaginatedData<Category>> readCategories(int page, int pageSize);
  Future<List<Category>> readAllCategories();
  Future<PaginatedData<Category>> searchCategories(
    String query,
    int page,
    int pageSize,
  );
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(String id);
}
