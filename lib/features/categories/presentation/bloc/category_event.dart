import 'package:admin/features/categories/domain/entities/category.dart';

sealed class CategoryEvent {}

class CreateCategory extends CategoryEvent {
  final Category category;

  CreateCategory(this.category);
}

class ReadCategories extends CategoryEvent {}

class SearchCategories extends CategoryEvent {
  final String query;

  SearchCategories(this.query);
}

class UpdateCategory extends CategoryEvent {
  final Category category;

  UpdateCategory(this.category);
}

class DeleteCategory extends CategoryEvent {
  final String id;

  DeleteCategory(this.id);
}

class ChangePage extends CategoryEvent {
  final int page;

  ChangePage(this.page);
}

class ChangePageSize extends CategoryEvent {
  final int pageSize;

  ChangePageSize(this.pageSize);
}
