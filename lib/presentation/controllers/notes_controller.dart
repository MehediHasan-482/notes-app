import 'package:get/get.dart';
import 'package:notesapp/domain/usecases/notes/add_notes_usecase.dart';
import 'package:notesapp/domain/usecases/notes/delete_notes_usecase.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/usecases/notes/get_notes_usecase.dart';

class NotesController extends GetxController {
  final GetNotesUseCase _getNotesUseCase;
  final AddNoteUseCase _addNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;

  NotesController({
    required GetNotesUseCase getNotesUseCase,
    required AddNoteUseCase addNoteUseCase,
    required DeleteNoteUseCase deleteNoteUseCase,
  })  : _getNotesUseCase = getNotesUseCase,
        _addNoteUseCase = addNoteUseCase,
        _deleteNoteUseCase = deleteNoteUseCase;

  final RxList<NoteEntity> notes = <NoteEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isAdding = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      notes.value = await _getNotesUseCase.call();
    } catch (e) {
      errorMessage.value = 'Failed to load notes.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addNote({required String title, required String description}) async {
    try {
      isAdding.value = true;
      errorMessage.value = '';
      await _addNoteUseCase.call(title: title, description: description);
      await fetchNotes();
      return true;
    } catch (e) {
      errorMessage.value = 'Failed to add note.';
      return false;
    } finally {
      isAdding.value = false;
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _deleteNoteUseCase.call(noteId);
      notes.removeWhere((n) => n.id == noteId);
    } catch (e) {
      errorMessage.value = 'Failed to delete note.';
    }
  }
}