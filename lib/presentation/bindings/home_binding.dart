import 'package:get/get.dart';
import 'package:notesapp/domain/usecases/notes/add_notes_usecase.dart';
import 'package:notesapp/domain/usecases/notes/delete_notes_usecase.dart';
import '../../data/datasources/supabase_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../controllers/auth_controller.dart';
import '../../data/repositories/notes_repository_impl.dart';
import '../../domain/usecases/notes/get_notes_usecase.dart';
import '../controllers/notes_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupabaseDataSource>(() => SupabaseDataSource());

    // Auth
    Get.lazyPut<AuthRepositoryImpl>(
      () => AuthRepositoryImpl(Get.find<SupabaseDataSource>()),
    );
    Get.lazyPut<LoginUseCase>(
      () => LoginUseCase(Get.find<AuthRepositoryImpl>()),
    );
    Get.lazyPut<RegisterUseCase>(
      () => RegisterUseCase(Get.find<AuthRepositoryImpl>()),
    );
    Get.lazyPut<LogoutUseCase>(
      () => LogoutUseCase(Get.find<AuthRepositoryImpl>()),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(
        loginUseCase: Get.find<LoginUseCase>(),
        registerUseCase: Get.find<RegisterUseCase>(),
        logoutUseCase: Get.find<LogoutUseCase>(),
      ),
    );
    Get.lazyPut<NotesRepositoryImpl>(
      () => NotesRepositoryImpl(Get.find<SupabaseDataSource>()),
    );
    Get.lazyPut<GetNotesUseCase>(
      () => GetNotesUseCase(Get.find<NotesRepositoryImpl>()),
    );
    Get.lazyPut<AddNoteUseCase>(
      () => AddNoteUseCase(Get.find<NotesRepositoryImpl>()),
    );
    Get.lazyPut<DeleteNoteUseCase>(
      () => DeleteNoteUseCase(Get.find<NotesRepositoryImpl>()),
    );
    Get.lazyPut<NotesController>(
      () => NotesController(
        getNotesUseCase: Get.find<GetNotesUseCase>(),
        addNoteUseCase: Get.find<AddNoteUseCase>(),
        deleteNoteUseCase: Get.find<DeleteNoteUseCase>(),
      ),
    );
  }
}
