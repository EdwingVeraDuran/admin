import 'package:admin/features/auth/data/supabase_auth_repo.dart';
import 'package:admin/features/auth/domain/auth_repo.dart';
import 'package:admin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // Repositories
  sl.registerLazySingleton<AuthRepo>(() => SupabaseAuthRepo());

  // Blocs
  sl.registerFactory(() => AuthBloc(sl<AuthRepo>()));
}
