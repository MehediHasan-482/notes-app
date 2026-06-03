import 'package:get/get.dart';
import '../../data/datasources/supabase_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupabaseDataSource>(() => SupabaseDataSource());
    Get.lazyPut<AuthRepositoryImpl>(
        () => AuthRepositoryImpl(Get.find<SupabaseDataSource>()));
    Get.lazyPut<LoginUseCase>(
        () => LoginUseCase(Get.find<AuthRepositoryImpl>()));
    Get.lazyPut<RegisterUseCase>(
        () => RegisterUseCase(Get.find<AuthRepositoryImpl>()));
    Get.lazyPut<LogoutUseCase>(
        () => LogoutUseCase(Get.find<AuthRepositoryImpl>()));
    Get.lazyPut<AuthController>(() => AuthController(
          loginUseCase: Get.find<LoginUseCase>(),
          registerUseCase: Get.find<RegisterUseCase>(),
          logoutUseCase: Get.find<LogoutUseCase>(),
        ));
  }
}