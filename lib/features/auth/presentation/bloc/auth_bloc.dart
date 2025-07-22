import 'package:admin/features/auth/domain/auth_repo.dart';
import 'package:admin/features/auth/presentation/bloc/auth_event.dart';
import 'package:admin/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) {
    emit(authRepo.hasSession() ? Authenticated() : Unauthenticated());
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await authRepo.login(event.email, event.password);
      emit(response ? Authenticated() : Unauthenticated());
    } catch (e) {
      emit(AuthError('Error login: $e'));
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    try {
      authRepo.logout();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError('Error logging out: $e'));
    }
  }
}
