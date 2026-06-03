import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../core/routes/app_router.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';

class AuthController extends GetxController {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthController({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _logoutUseCase = logoutUseCase;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> login({required String email, required String password}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _loginUseCase.call(email: email, password: password);
      Get.context!.go(AppRoutes.home);
    } catch (e) {
      errorMessage.value = _parseError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _registerUseCase.call(name: name, email: email, password: password);
      Get.context!.go(AppRoutes.home);
    } catch (e) {
      errorMessage.value = _parseError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _logoutUseCase.call();
      Get.context!.go(AppRoutes.login);
    } catch (e) {
      errorMessage.value = _parseError(e);
    }
  }

  String _parseError(dynamic e) {
    final msg = e.toString().toLowerCase();
    if (msg.contains('invalid login credentials')) return 'Invalid email or password.';
    if (msg.contains('email already registered')) return 'Email already in use.';
    if (msg.contains('network')) return 'Network error. Please try again.';
    return 'Something went wrong. Please try again.';
  }
}