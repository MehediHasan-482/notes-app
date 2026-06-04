import '../../repositories/notes_repository.dart';

class AddNoteUseCase {
  final NotesRepository _repo;
  AddNoteUseCase(this._repo);
  Future<void> call({required String title, required String description}) =>
      _repo.addNote(title: title, description: description);
}