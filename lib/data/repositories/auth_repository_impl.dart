import '../../domain/repositories/auth_repository.dart';
import '../datasources/supabase_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseDataSource _dataSource;
  AuthRepositoryImpl(this._dataSource);

  @override
  Future<void> login({required String email, required String password}) {
    return _dataSource.login(email: email, password: password);
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) {
    return _dataSource.register(name: name, email: email, password: password);
  }

  @override
  Future<void> logout() => _dataSource.logout();
}