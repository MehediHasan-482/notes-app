import '../../repositories/notes_repository.dart';

class DeleteNoteUseCase {
  final NotesRepository _repo;
  DeleteNoteUseCase(this._repo);
  Future<void> call(String noteId) => _repo.deleteNote(noteId);
} 