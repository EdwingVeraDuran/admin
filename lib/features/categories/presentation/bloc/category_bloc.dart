import 'package:admin/core/models/query.dart';
import 'package:admin/features/categories/domain/repos/category_repo.dart';
import 'package:admin/features/categories/presentation/bloc/category_event.dart';
import 'package:admin/features/categories/presentation/bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepo categoryRepo;

  Query _query = Query(page: 1, pageSize: 10);
  int totalPages = 1;

  CategoryBloc(this.categoryRepo) : super(CategoriesInitial()) {
    on<CreateCategory>(_onCreateCategory);
    on<ReadCategories>(_onReadCategories);
    on<SearchCategories>(_onSearchCategories);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
    on<ChangePage>(_onChangePage);
    on<ChangePageSize>(_onChangePageSize);
    add(ReadCategories());
  }

  Future<void> _onCreateCategory(
    CreateCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await categoryRepo.createCategory(event.category);
      add(ReadCategories());
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> _onReadCategories(
    ReadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(CategoriesLoading());
      final response = _query.isSearch
          ? await categoryRepo.readCategories(_query.page, _query.pageSize)
          : await categoryRepo.searchCategories(
              _query.query!,
              _query.page,
              _query.pageSize,
            );
      totalPages = (response.total / _query.pageSize).ceil();
      emit(
        response.data.isNotEmpty
            ? CategoriesList(
                response.data,
                page: _query.page,
                pageSize: _query.pageSize,
                totalPages: totalPages,
              )
            : CategoriesEmpty(),
      );
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  void _onSearchCategories(
    SearchCategories event,
    Emitter<CategoryState> emit,
  ) {
    _query = _query.copyWith(page: 1, query: event.query);
    add(ReadCategories());
  }

  Future<void> _onUpdateCategory(
    UpdateCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await categoryRepo.updateCategory(event.category);
      add(ReadCategories());
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await categoryRepo.deleteCategory(event.id);
      add(ReadCategories());
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  void _onChangePageSize(ChangePageSize event, Emitter<CategoryState> emit) {
    _query = _query.copyWith(page: 1, pageSize: event.pageSize);
    add(ReadCategories());
  }

  void _onChangePage(ChangePage event, Emitter<CategoryState> emit) {
    _query = _query.copyWith(page: event.page);
    add(ReadCategories());
  }
}
