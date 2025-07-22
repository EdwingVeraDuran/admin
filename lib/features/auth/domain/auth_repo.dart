abstract class AuthRepo {
  Future<bool> login(String email, String password);
  Future<void> logout();
  bool hasSession();
}
