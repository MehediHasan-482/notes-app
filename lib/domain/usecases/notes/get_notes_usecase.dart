import '../../entities/note_entity.dart';
import '../../repositories/notes_repository.dart';

class GetNotesUseCase {
  final NotesRepository _repo;
  GetNotesUseCase(this._repo);
  Future<List<NoteEntity>> call() => _repo.getNotes();
}