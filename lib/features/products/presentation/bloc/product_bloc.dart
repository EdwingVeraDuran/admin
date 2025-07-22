import 'package:admin/core/models/query.dart';
import 'package:admin/features/products/domain/repos/product_repo.dart';
import 'package:admin/features/products/presentation/bloc/product_event.dart';
import 'package:admin/features/products/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;

  Query _query = Query(page: 1, pageSize: 10);
  int totalPages = 1;

  ProductBloc(this.productRepo) : super(ProductsInitial()) {
    on<CreateProduct>(_onCreateProduct);
    on<ReadProducts>(_onReadProducts);
    on<SearchProducts>(_onSearchProducts);
    on<ChangePage>(_onChangePage);
    on<ChangePageSize>(_onChangePageSize);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);

    add(ReadProducts());
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }

  Future<void> _onReadProducts(
    ReadProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductsLoading());

      final response = _query.isSearch
          ? await productRepo.searchProducts(
              _query.query!,
              _query.page,
              _query.pageSize,
            )
          : await productRepo.readProducts(_query.page, _query.pageSize);

      totalPages = (response.total / _query.pageSize).ceil();

      emit(
        response.data.isNotEmpty
            ? ProductsList(
                response.data,
                page: _query.page,
                pageSize: _query.pageSize,
                totalPages: totalPages,
              )
            : ProductsEmpty(),
      );
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    _query = _query.copyWith(page: 1, query: event.query);
    add(ReadProducts());
  }

  void _onChangePage(ChangePage event, Emitter<ProductState> emit) {
    _query = _query.copyWith(page: event.page);
    add(ReadProducts());
  }

  void _onChangePageSize(ChangePageSize event, Emitter<ProductState> emit) {
    _query = _query.copyWith(page: 1, pageSize: event.pageSize);
    add(ReadProducts());
  }

  Future<void> _onCreateProduct(
    CreateProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await productRepo.createProduct(event.product, event.image);
      add(ReadProducts());
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await productRepo.updateProduct(event.product, event.image);
      add(ReadProducts());
    } catch (e, stackTrace) {
      emit(ProductsError(e.toString()));
      addError(e, stackTrace);
    }
  }

  Future<void> _onDeleteProduct(
    DeleteProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await productRepo.deleteProduct(event.id);
      add(ReadProducts());
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
