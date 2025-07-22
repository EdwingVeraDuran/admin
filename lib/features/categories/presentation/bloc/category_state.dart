import 'package:admin/features/categories/domain/entities/category.dart';

sealed class CategoryState {}

class CategoriesInitial extends CategoryState {}

class CategoriesLoading extends CategoryState {}

class CategoriesList extends CategoryState {
  final List<Category> categories;
  final int page;
  final int pageSize;
  final int totalPages;

  CategoriesList(
    this.categories, {
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });
}

class CategoriesEmpty extends CategoryState {}

class CategoriesError extends CategoryState {
  final String message;

  CategoriesError(this.message);
}
