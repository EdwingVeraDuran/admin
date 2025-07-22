import 'package:admin/features/auth/data/supabase_auth_repo.dart';
import 'package:admin/features/auth/domain/auth_repo.dart';
import 'package:admin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:admin/features/products/data/supabase_product_repo.dart';
import 'package:admin/features/products/domain/repos/product_repo.dart';
import 'package:admin/features/products/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // Auth
  sl.registerLazySingleton<AuthRepo>(() => SupabaseAuthRepo());
  sl.registerFactory(() => AuthBloc(sl<AuthRepo>()));
  // Product
  sl.registerLazySingleton<ProductRepo>(() => SupabaseProductRepo());
  sl.registerFactory(() => ProductBloc(sl<ProductRepo>()));
}
