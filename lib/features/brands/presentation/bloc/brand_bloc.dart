import 'package:admin/core/models/query.dart';
import 'package:admin/features/brands/domain/repos/brand_repo.dart';
import 'package:admin/features/brands/presentation/bloc/brand_event.dart';
import 'package:admin/features/brands/presentation/bloc/brand_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandRepo brandRepo;

  Query _query = Query(page: 1, pageSize: 10);
  int totalPages = 1;

  BrandBloc(this.brandRepo) : super(BrandsInitial()) {
    on<CreateBrand>(_onCreateBrand);
    on<ReadBrands>(_onReadBrands);
    on<SearchBrands>(_onSearchBrands);
    on<UpdateBrand>(_onUpdateBrand);
    on<DeleteBrand>(_onDeleteBrand);
    on<ChangePage>(_onChangePage);
    on<ChangePageSize>(_onChangePageSize);
    add(ReadBrands());
  }

  Future<void> _onCreateBrand(
    CreateBrand event,
    Emitter<BrandState> emit,
  ) async {
    try {
      await brandRepo.createBrand(event.brand);
      add(ReadBrands());
    } catch (e) {
      emit(BrandsError(e.toString()));
    }
  }

  Future<void> _onReadBrands(ReadBrands event, Emitter<BrandState> emit) async {
    try {
      emit(BrandsLoading());
      final response = _query.isSearch
          ? await brandRepo.searchBrands(
              _query.query!,
              _query.page,
              _query.pageSize,
            )
          : await brandRepo.readBrands(_query.page, _query.pageSize);
      totalPages = (response.total / _query.pageSize).ceil();
      emit(
        response.data.isNotEmpty
            ? BrandsList(
                response.data,
                page: _query.page,
                pageSize: _query.pageSize,
                totalPages: totalPages,
              )
            : BrandsEmpty(),
      );
    } catch (e) {
      emit(BrandsError(e.toString()));
    }
  }

  Future<void> _onSearchBrands(
    SearchBrands event,
    Emitter<BrandState> emit,
  ) async {
    _query = _query.copyWith(page: 1, query: event.query);
    add(ReadBrands());
  }

  Future<void> _onUpdateBrand(
    UpdateBrand event,
    Emitter<BrandState> emit,
  ) async {
    try {
      await brandRepo.updateBrand(event.brand);
      add(ReadBrands());
    } catch (e) {
      emit(BrandsError(e.toString()));
    }
  }

  Future<void> _onDeleteBrand(
    DeleteBrand event,
    Emitter<BrandState> emit,
  ) async {
    try {
      await brandRepo.deleteBrand(event.id);
      add(ReadBrands());
    } catch (e) {
      emit(BrandsError(e.toString()));
    }
  }

  void _onChangePageSize(ChangePageSize event, Emitter<BrandState> emit) {
    _query = _query.copyWith(page: 1, pageSize: event.pageSize);
    add(ReadBrands());
  }

  void _onChangePage(ChangePage event, Emitter<BrandState> emit) {
    _query = _query.copyWith(page: event.page);
    add(ReadBrands());
  }
}
